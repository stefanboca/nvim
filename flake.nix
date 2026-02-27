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

    # used for input follows
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";

    # keep-sorted start block=yes newline_separated=yes
    blink-cmp = {
      url = "github:saghen/blink.cmp";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        fenix.follows = "fenix";
        flake-parts.follows = "flake-parts";
      };
    };

    blink-lib = {
      url = "github:saghen/blink.lib";
      flake = false;
    };

    blink-pairs = {
      url = "github:saghen/blink.pairs";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        fenix.follows = "fenix";
        flake-parts.follows = "flake-parts";
      };
    };

    clasp-nvim = {
      url = "github:xzbdmw/clasp.nvim";
      flake = false;
    };

    filler-begone-nvim = {
      url = "github:saghen/filler-begone.nvim";
      flake = false;
    };

    jj-diffconflicts = {
      url = "github:rafikdraoui/jj-diffconflicts";
      flake = false;
    };

    tiny-code-action-nvim = {
      url = "github:rachartier/tiny-code-action.nvim";
      flake = false;
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    unnest-nvim = {
      url = "github:brianhuster/unnest.nvim";
      flake = false;
    };
    # keep-sorted end
  };

  outputs = {
    self,
    nixpkgs,
    treefmt-nix,
    ...
  }: let
    inherit (nixpkgs) lib;
    inherit (lib.attrsets) genAttrs mapAttrs' nameValuePair;

    systems = ["x86_64-linux" "aarch64-linux"];

    forAllSystems = genAttrs systems;
    nixpkgsFor = forAllSystems (system: nixpkgs.legacyPackages.${system});
    treefmtFor = forAllSystems (system: treefmt-nix.lib.evalModule nixpkgsFor.${system} ./treefmt.nix);

    snv-package = import ./package.nix self;
  in {
    packages = forAllSystems (system: rec {
      default = snv;
      snv = nixpkgsFor.${system}.callPackage snv-package {};
    });

    overlays.default = final: _: {
      snv = final.callPackage snv-package {};
    };

    formatter = forAllSystems (system: treefmtFor.${system}.config.build.wrapper);

    checks = forAllSystems (system: let
      packages = mapAttrs' (n: nameValuePair "package-${n}") self.packages.${system};
      formatting = {formatting = treefmtFor.${system}.config.build.check self;};
    in
      packages // formatting);
  };
}
