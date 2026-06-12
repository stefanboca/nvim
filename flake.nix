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
        blink-lib.follows = "blink-lib";
      };
    };

    blink-lib = {
      url = "github:saghen/blink.lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    blink-pairs = {
      url = "github:saghen/blink.pairs";
      inputs.nixpkgs.follows = "nixpkgs";
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

  outputs = inputs @ {
    self,
    nixpkgs,
    treefmt-nix,
    ...
  }: let
    inherit (nixpkgs) lib;
    inherit (lib.attrsets) genAttrs mapAttrs' nameValuePair;

    systems = ["x86_64-linux" "aarch64-linux"];

    forAllSystems = genAttrs systems;
    nixpkgsFor = forAllSystems (system:
      import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          inputs.blink-cmp.overlays.default
          inputs.blink-lib.overlays.default
          inputs.blink-pairs.overlays.default
          inputs.fenix.overlays.default
          inputs.neovim-nightly-overlay.overlays.default
        ];
      });
    treefmtFor = forAllSystems (system: treefmt-nix.lib.evalModule nixpkgsFor.${system} ./treefmt.nix);

    snv-package = import ./package.nix self;
  in {
    packages = forAllSystems (system: rec {
      default = snv;
      snv = nixpkgsFor.${system}.callPackage snv-package {};
      snv-minimal = snv.override {minimal = true;};
    });

    overlays.default = final: prev: {
      snv = final.callPackage snv-package {};
      snv-minimal = final.snv.override {minimal = true;};

      # see https://github.com/nix-community/neovim-nightly-overlay/pull/1305
      neovim-unwrapped = prev.neovim-unwrapped.overrideAttrs (prevAttrs: {
        patches = builtins.filter (patch: !lib.hasInfix "CVE-2026-11487" (toString patch)) (
          prevAttrs.patches or []
        );
      });
    };

    formatter = forAllSystems (system: treefmtFor.${system}.config.build.wrapper);

    checks = forAllSystems (system: let
      packages = mapAttrs' (n: nameValuePair "package-${n}") self.packages.${system};
      formatting = {formatting = treefmtFor.${system}.config.build.check self;};
    in
      packages // formatting);
  };
}
