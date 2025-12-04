{
  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    neovim-nightly-overlay.inputs = {
      nixpkgs.follows = "nixpkgs";
      flake-parts.follows = "flake-parts";
    };

    fenix.url = "github:nix-community/fenix";
    fenix.inputs.nixpkgs.follows = "nixpkgs";

    # plugins
    blink-cmp.url = "github:Saghen/blink.cmp";
    blink-cmp.inputs = {
      nixpkgs.follows = "nixpkgs";
      fenix.follows = "fenix";
      flake-parts.follows = "flake-parts";
    };

    blink-pairs.url = "github:Saghen/blink.pairs";
    blink-pairs.inputs = {
      nixpkgs.follows = "nixpkgs";
      fenix.follows = "fenix";
      flake-parts.follows = "flake-parts";
    };

    blink-lib.url = "github:Saghen/blink.lib";
    blink-lib.flake = false;

    clasp-nvim.url = "github:xzbdmw/clasp.nvim";
    clasp-nvim.flake = false;

    filler-begone-nvim.url = "github:Saghen/filler-begone.nvim";
    filler-begone-nvim.flake = false;

    jj-diffconflicts.url = "github:rafikdraoui/jj-diffconflicts";
    jj-diffconflicts.flake = false;

    nvim-treesitter-main.url = "github:iofq/nvim-treesitter-main";
    nvim-treesitter-main.inputs = {
      nixpkgs.follows = "nixpkgs";
      nvim-treesitter.follows = "nvim-treesitter";
      nvim-treesitter-textobjects.follows = "nvim-treesitter-textobjects";
    };

    tiny-code-action-nvim.url = "github:rachartier/tiny-code-action.nvim";
    tiny-code-action-nvim.flake = false;

    unnest-nvim.url = "github:brianhuster/unnest.nvim";
    unnest-nvim.flake = false;

    vim-jjdescription.url = "github:avm99963/vim-jjdescription";
    vim-jjdescription.flake = false;

    # used for input follows
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";

    nvim-treesitter.url = "github:nvim-treesitter/nvim-treesitter/main";
    nvim-treesitter.flake = false;

    nvim-treesitter-textobjects.url = "github:nvim-treesitter/nvim-treesitter-textobjects/main";
    nvim-treesitter-textobjects.flake = false;
  };

  outputs = {
    fenix,
    neovim-nightly-overlay,
    nixpkgs,
    nvim-treesitter-main,
    self,
    ...
  } @ inputs: let
    inherit (nixpkgs) lib;
    inherit (lib.attrsets) genAttrs;

    mkPkgs = system:
      import nixpkgs {
        inherit system;
        overlays = [
          fenix.overlays.default
          nvim-treesitter-main.overlays.default
          self.overlays.default
        ];
      };

    systems = ["x86_64-linux" "aarch64-linux"];
    forAllSystems = f: genAttrs systems (system: f (mkPkgs system));

    mkVimPlugins = pkgs: let
      inherit (pkgs.stdenv.hostPlatform) system;
    in {
      inherit (inputs.blink-cmp.packages.${system}) blink-cmp;
      blink-pairs = inputs.blink-pairs.packages.${system}.blink-pairs // {pname = "blink.pairs";};

      blink-lib = pkgs.vimUtils.buildVimPlugin {
        pname = "blink.lib";
        version = inputs.blink-lib.rev;
        src = inputs.blink-lib;
      };

      clasp-nvim = pkgs.vimUtils.buildVimPlugin {
        pname = "clasp.nvim";
        version = inputs.clasp-nvim.rev;
        src = inputs.clasp-nvim;
      };

      filler-begone-nvim = pkgs.vimUtils.buildVimPlugin {
        pname = "filler-begone.nvim";
        version = inputs.filler-begone-nvim.rev;
        src = inputs.filler-begone-nvim;
      };

      jj-diffconflicts = pkgs.vimUtils.buildVimPlugin {
        pname = "jj-diffconflicts";
        version = inputs.jj-diffconflicts.rev;
        src = inputs.jj-diffconflicts;
      };

      tiny-code-action-nvim = pkgs.vimUtils.buildVimPlugin {
        name = "tiny-code-action.nvim";
        version = inputs.tiny-code-action-nvim.rev;
        src = inputs.tiny-code-action-nvim;
        nvimSkipModules = [
          "tiny-code-action.backend.delta"
          "tiny-code-action.backend.diffsofancy"
          "tiny-code-action.backend.difftastic"
          "tiny-code-action.previewers.snacks"
        ];
      };

      unnest-nvim = pkgs.vimUtils.buildVimPlugin {
        pname = "unnest.nvim";
        version = inputs.unnest-nvim.rev;
        src = inputs.unnest-nvim;
      };

      vim-jjdescription = pkgs.vimUtils.buildVimPlugin {
        pname = "vim-jjdescription";
        version = inputs.vim-jjdescription.rev;
        src = inputs.vim-jjdescription;
      };
    };

    mkPackages = pkgs: {
      snv = pkgs.callPackage ./snv.nix {
        inherit (neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}) neovim;
        src = self;
      };
      snv-dev = pkgs.callPackage ./snv.nix {
        inherit (neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}) neovim;
        src = self;
        dev = true;
      };
      snv-profile = pkgs.callPackage ./snv.nix {
        inherit (neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}) neovim;
        src = self;
        profile = true;
      };
    };
  in {
    packages = forAllSystems (pkgs: let
      packages = mkPackages pkgs;
    in
      {default = packages.snv;} // packages // (mkVimPlugins pkgs));

    overlays.default = _final: prev:
      (mkPackages prev) // {vimPlugins = prev.vimPlugins // (mkVimPlugins prev);};
  };
}
