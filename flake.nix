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
    blink-cmp.url = "github:saghen/blink.cmp";
    blink-cmp.inputs = {
      nixpkgs.follows = "nixpkgs";
      fenix.follows = "fenix";
      flake-parts.follows = "flake-parts";
    };

    blink-pairs.url = "github:saghen/blink.pairs";
    blink-pairs.inputs = {
      nixpkgs.follows = "nixpkgs";
      fenix.follows = "fenix";
      flake-parts.follows = "flake-parts";
    };

    blink-lib.url = "github:saghen/blink.lib";
    blink-lib.flake = false;

    clasp-nvim.url = "github:xzbdmw/clasp.nvim";
    clasp-nvim.flake = false;

    filler-begone-nvim.url = "github:saghen/filler-begone.nvim";
    filler-begone-nvim.flake = false;

    jj-diffconflicts.url = "github:rafikdraoui/jj-diffconflicts";
    jj-diffconflicts.flake = false;

    nvim-treesitter-main.url = "github:iofq/nvim-treesitter-main";
    nvim-treesitter-main.inputs.nixpkgs.follows = "nixpkgs";

    tiny-code-action-nvim.url = "github:rachartier/tiny-code-action.nvim";
    tiny-code-action-nvim.flake = false;

    unnest-nvim.url = "github:brianhuster/unnest.nvim";
    unnest-nvim.flake = false;

    # used for input follows
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
  };

  outputs = {
    nixpkgs,
    self,
    ...
  } @ inputs: let
    inherit (nixpkgs) lib;
    inherit (lib.attrsets) genAttrs;

    systems = ["x86_64-linux" "aarch64-linux"];
    mkPkgs = system:
      import nixpkgs {
        inherit system;
        overlays = [self.overlays.default];
      };
    forAllSystems = f: genAttrs systems (system: f (mkPkgs system));
  in {
    packages = forAllSystems (pkgs: {
      default = pkgs.snv;
      inherit (pkgs) snv;
    });

    overlays.default = _: prev: let
      vimPluginsOverlay = final': prev': let
        inherit (final'.stdenv.hostPlatform) system;

        buildVimPlugin = attrs: prev'.vimUtils.buildVimPlugin ({version = "0.0.0+rev=${attrs.src.shortRev}";} // attrs);
      in {
        vimPlugins = prev'.vimPlugins.extend (
          f: p: {
            nvim-treesitter = p.nvim-treesitter.withAllGrammars;
            nvim-treesitter-textobjects = p.nvim-treesitter-textobjects.overrideAttrs {dependencies = [f.nvim-treesitter];};

            inherit (inputs.blink-cmp.packages.${system}) blink-cmp;
            inherit (inputs.blink-pairs.packages.${system}) blink-pairs;

            blink-lib = buildVimPlugin {
              pname = "blink.lib";
              src = inputs.blink-lib;
            };

            clasp-nvim = buildVimPlugin {
              pname = "clasp.nvim";
              src = inputs.clasp-nvim;
            };

            filler-begone-nvim = buildVimPlugin {
              pname = "filler-begone.nvim";
              src = inputs.filler-begone-nvim;
            };

            jj-diffconflicts = buildVimPlugin {
              pname = "jj-diffconflicts";
              src = inputs.jj-diffconflicts;
            };

            tiny-code-action-nvim = buildVimPlugin {
              pname = "tiny-code-action.nvim";
              src = inputs.tiny-code-action-nvim;
              nvimSkipModules = [
                "tiny-code-action.backend.delta"
                "tiny-code-action.backend.diffsofancy"
                "tiny-code-action.backend.difftastic"
                "tiny-code-action.previewers.snacks"
              ];
            };

            unnest-nvim = buildVimPlugin {
              pname = "unnest.nvim";
              src = inputs.unnest-nvim;
            };
          }
        );
      };

      pkgs = prev.appendOverlays [
        inputs.fenix.overlays.default
        inputs.neovim-nightly-overlay.overlays.default
        inputs.nvim-treesitter-main.overlays.default
        vimPluginsOverlay
      ];
    in {
      snv = pkgs.callPackage ./default.nix {
        version = "0.0.0+rev=${self.shortRev or self.dirtyShortRev}";
      };
    };
  };
}
