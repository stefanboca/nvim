{
  # keep-sorted start
  alejandra,
  basedpyright,
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
  rust-analyzer-nightly,
  shfmt,
  sqlite,
  statix,
  stdenvNoCC,
  stylua,
  svelte-language-server,
  tailwindcss-language-server,
  tinymist,
  tombi,
  ts_query_ls,
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
  neovim-unwrapped,
  vimPlugins,
  version,
  extraStartPlugins ? [],
  extraOptPlugins ? [],
  extraLibs ? [],
  extraPackages ? [],
  extraSearchPaths ? [],
  ...
}: let
  inherit (lib.fileset) fileFilter toSource unions;
  inherit (lib.meta) getExe;
  inherit (lib.strings) concatStringsSep getName makeBinPath makeLibraryPath;

  startPlugins = with vimPlugins; [
    # keep-sorted start
    SchemaStore-nvim
    catppuccin-nvim
    jj-diffconflicts
    mini-nvim
    nui-nvim
    nvim-nio
    nvim-treesitter
    plenary-nvim
    unnest-nvim
    vim-jjdescription
    # keep-sorted end
  ];
  optPlugins = with vimPlugins; [
    # keep-sorted start
    blink-cmp
    blink-indent
    blink-lib
    blink-pairs
    clasp-nvim
    conform-nvim
    crates-nvim
    dial-nvim
    diffview-nvim
    filler-begone-nvim
    grug-far-nvim
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
    rustaceanvim
    snacks-nvim
    tiny-code-action-nvim
    toggleterm-nvim
    trouble-nvim
    # keep-sorted end
  ];

  libs = [sqlite];

  packages = [
    # keep-sorted start
    alejandra # nix
    basedpyright # python
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
    rust-analyzer-nightly
    shfmt
    statix # nix
    stylua # lua
    svelte-language-server
    tailwindcss-language-server
    tinymist # typst
    tombi # toml
    ts_query_ls
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

  neovimExe = getExe neovim-unwrapped;
in
  stdenvNoCC.mkDerivation {
    pname = "snv";
    inherit version plugins;

    src = toSource {
      root = ./.;
      fileset = unions [
        (fileFilter (file: file.hasExt "lua") ./.)
        (fileFilter (file: file.hasExt "scm") ./.)
      ];
    };

    phases = ["unpackPhase" "installPhase"];
    preferLocalBuild = true;

    nativeBuildInputs = [makeWrapper];

    installPhase = ''
      mkdir -p $out/share/snv
      substitute ${./init.lua.in} $out/share/snv/init.lua --subst-var out --subst-var plugins
      ln -s $src $out/share/snv/site

      makeWrapper ${neovimExe} $out/bin/snv --argv0 snv ${wrapperArgs}
      makeWrapper ${neovimExe} $out/bin/snv-dev --argv0 snv-dev --add-flags '--cmd "lua vim.g.snv_dev=true"' ${wrapperArgs}
      makeWrapper ${neovimExe} $out/bin/snv-profile --argv0 snv-profile --add-flags '--cmd "lua vim.g.snv_dev=true" --cmd "lua vim.g.snv_profile=true"' ${wrapperArgs}
    '';

    meta = {
      homepage = "https://github.com/stefanboca/nvim";
      mainProgram = "snv";
    };
  }
