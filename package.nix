self: {
  # keep-sorted start
  alejandra,
  bash-language-server,
  biome,
  clang-tools,
  cmake-lint,
  deadnix,
  docker-language-server,
  dockerfmt,
  emmylua-ls,
  fd,
  fish-lsp,
  glsl_analyzer,
  graphviz,
  hadolint,
  harper,
  inotify-tools,
  jdt-language-server,
  just-lsp,
  kdlfmt,
  keep-sorted,
  koto-ls,
  lspmux,
  lua-language-server,
  markdownlint-cli2,
  marksman,
  neocmakelsp,
  nil,
  prettierd,
  python313Packages,
  ripgrep,
  ruff,
  shfmt,
  sqlite,
  statix,
  stylua,
  svelte-language-server,
  tailwindcss-language-server,
  tinymist,
  tombi,
  ts_query_ls,
  ty,
  typstyle,
  vscode-extensions,
  vscode-langservers-extracted,
  vtsls,
  wl-clipboard,
  yaml-language-server,
  zls,
  # keep-sorted end
  lib,
  linkFarm,
  makeWrapper,
  stdenvNoCC,
  symlinkJoin,
  vimPlugins,
  vimUtils,
  extraStartPlugins ? [],
  extraOptPlugins ? [],
  extraLibs ? [],
  extraPackages ? [],
  extraSearchPaths ? [],
  ...
}: let
  inherit (lib.fileset) fileFilter toSource unions;
  inherit (lib.lists) concatMap unique;
  inherit (lib.meta) getExe;
  inherit (lib.strings) concatStringsSep getName makeBinPath makeLibraryPath;

  inherit (stdenvNoCC.hostPlatform) system;
  buildVimPlugin = attrs: vimUtils.buildVimPlugin ({version = "0.0.0+rev=${attrs.src.shortRev}";} // attrs);
  allDeps = plugins:
    concatMap (p:
      if p ? dependencies && p.dependencies != []
      then [p] ++ allDeps p.dependencies
      else [p])
    plugins;

  inherit (self.inputs.blink-cmp.packages.${system}) blink-cmp;
  inherit (self.inputs.blink-pairs.packages.${system}) blink-pairs;
  inherit (self.inputs.fenix.packages.${system}) rust-analyzer;
  # keep-sorted start block=yes
  blink-lib = buildVimPlugin {
    pname = "blink.lib";
    src = self.inputs.blink-lib;
  };
  clasp-nvim = buildVimPlugin {
    pname = "clasp.nvim";
    src = self.inputs.clasp-nvim;
  };
  filler-begone-nvim = buildVimPlugin {
    pname = "filler-begone.nvim";
    src = self.inputs.filler-begone-nvim;
  };
  jj-diffconflicts = buildVimPlugin {
    pname = "jj-diffconflicts";
    src = self.inputs.jj-diffconflicts;
  };
  nvim-treesitter = vimPlugins.nvim-treesitter.withAllGrammars;
  nvim-treesitter-runtime = symlinkJoin {
    name = "nvim-treesitter-runtime";
    paths = unique (allDeps nvim-treesitter.dependencies);
  };
  tiny-code-action-nvim = buildVimPlugin {
    pname = "tiny-code-action.nvim";
    src = self.inputs.tiny-code-action-nvim;
    nvimSkipModules = [
      "tiny-code-action.backend.delta"
      "tiny-code-action.backend.diffsofancy"
      "tiny-code-action.backend.difftastic"
      "tiny-code-action.previewers.snacks"
    ];
  };
  unnest-nvim = buildVimPlugin {
    pname = "unnest.nvim";
    src = self.inputs.unnest-nvim;
  };
  # keep-sorted end

  startPlugins =
    [
      # keep-sorted start
      clasp-nvim
      filler-begone-nvim
      jj-diffconflicts
      nvim-treesitter
      unnest-nvim
      # keep-sorted end
    ]
    ++ (with vimPlugins; [
      # keep-sorted start
      SchemaStore-nvim
      catppuccin-nvim
      diffview-nvim
      grug-far-nvim
      mini-nvim
      nui-nvim
      nvim-nio
      plenary-nvim
      rustaceanvim
      vim-jjdescription
      # keep-sorted end
    ]);

  optPlugins =
    [
      # keep-sorted start
      blink-cmp
      blink-lib
      blink-pairs
      nvim-treesitter-runtime # manually added to rtp in init.lua
      tiny-code-action-nvim
      # keep-sorted end
    ]
    ++ (with vimPlugins; [
      # keep-sorted start
      blink-indent
      conform-nvim
      crates-nvim
      dial-nvim
      hunk-nvim
      lazydev-nvim
      lean-nvim
      live-rename-nvim
      neogen
      neogit
      neotest
      neotest-python
      nvim-dap
      nvim-dap-python
      nvim-dap-view
      nvim-dap-virtual-text
      nvim-lint
      nvim-lspconfig
      nvim-treesitter-context
      nvim-treesitter-textobjects
      nvim-ts-autotag
      one-small-step-for-vimkind
      snacks-nvim
      toggleterm-nvim
      trouble-nvim
      # keep-sorted end
    ]);

  libs = [sqlite];

  packages = [
    # keep-sorted start
    alejandra # nix
    bash-language-server
    biome
    clang-tools # c/cpp
    cmake-lint
    deadnix # nix
    docker-language-server
    dockerfmt
    emmylua-ls # lua
    fd
    fish-lsp
    glsl_analyzer
    graphviz # for crate graph visualtization
    hadolint # docker
    harper
    inotify-tools
    jdt-language-server # java
    just-lsp
    kdlfmt
    keep-sorted
    koto-ls
    lspmux
    lua-language-server
    markdownlint-cli2
    marksman # markdown
    neocmakelsp # cmake
    nil # nix
    prettierd
    python313Packages.debugpy
    ripgrep
    ruff # python
    rust-analyzer
    shfmt
    statix # nix
    stylua # lua
    svelte-language-server
    tailwindcss-language-server
    tinymist # typst
    tombi # toml
    ts_query_ls
    ty # python
    typstyle # typst
    vscode-langservers-extracted # vscode-{css, eslint, html, json, markdown}-language-server
    vtsls # typescript
    wl-clipboard
    yaml-language-server
    zls # zig
    # keep-sorted end
  ];

  searchPaths = [
    "${vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter"
  ];

  allStartPlugins = startPlugins ++ extraStartPlugins;
  allOptPlugins = optPlugins ++ extraOptPlugins;
  allLibs = libs ++ extraLibs;
  allPackages = packages ++ extraPackages;
  allSearchPaths = searchPaths ++ extraSearchPaths;

  mkPluginPaths = type:
    map (plugin: {
      name = "pack/plugins/${type}/${getName plugin}";
      path = plugin;
    });
  pluginPaths = (mkPluginPaths "start" allStartPlugins) ++ (mkPluginPaths "opt" allOptPlugins);
  plugins = linkFarm "snv-plugins" pluginPaths;

  wrapperArgs = concatStringsSep " " [
    "--suffix LD_LIBRARY_PATH : ${makeLibraryPath allLibs}"
    "--suffix PATH : ${(makeBinPath allPackages)}:${(concatStringsSep ":" allSearchPaths)}"
    ''--add-flags "-u $out/share/snv/init.lua"''
  ];

  neovim = self.inputs.neovim-nightly-overlay.packages.${system}.neovim.overrideAttrs {
    # the defaults are unused at runtime, because nvim-treesitter parsers take precedence.
    treesitter-parsers = {};
  };
  neovimExe = getExe neovim;
in
  stdenvNoCC.mkDerivation {
    pname = "snv";
    version = "0.0.0+rev=${self.shortRev or self.dirtyShortRev}";

    strictDeps = true;
    preferLocalBuild = true;

    src = toSource {
      root = ./.;
      fileset = unions [
        (fileFilter (file: file.hasExt "lua") ./.)
        (fileFilter (file: file.hasExt "scm") ./.)
        ./init.lua.in
      ];
    };

    nativeBuildInputs = [makeWrapper];

    env = {
      inherit plugins;
    };

    dontPatch = true;
    dontConfigure = true;
    dontBuild = true;
    dontFixup = true;

    installPhase = ''
      mkdir -p $out/share/snv
      substitute ./init.lua.in $out/share/snv/init.lua --subst-var out --subst-var plugins
      ln -s $src $out/share/snv/site

      makeWrapper ${neovimExe} $out/bin/snv --argv0 snv ${wrapperArgs}
      makeWrapper ${neovimExe} $out/bin/snv-dev --argv0 snv-dev --add-flags '--cmd "lua vim.g.snv_dev=true"' ${wrapperArgs}
      makeWrapper ${neovimExe} $out/bin/snv-profile --argv0 snv-profile --add-flags '--cmd "lua vim.g.snv_dev=true" --cmd "lua vim.g.snv_profile=true"' ${wrapperArgs}
    '';

    passthru = {
      inherit neovim;
    };

    meta = {
      homepage = "https://github.com/stefanboca/nvim";
      mainProgram = "snv";
    };
  }
