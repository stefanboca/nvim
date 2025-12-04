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
  fish-lsp,
  glsl_analyzer,
  graphviz,
  hadolint,
  harper,
  inotify-tools,
  jdt-language-server,
  just-lsp,
  keep-sorted,
  koto-ls,
  lean4,
  lua-language-server,
  markdownlint-cli2,
  marksman,
  neocmakelsp,
  nil,
  prettierd,
  python313Packages,
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
  runCommandWith,
  vimPlugins,
  writeTextFile,
  src,
  dev ? false,
  profile ? false,
  ...
}: let
  inherit (lib.meta) getExe;
  inherit (lib.strings) concatStringsSep getName makeBinPath makeLibraryPath optionalString;

  startPlugins = with vimPlugins; [
    # keep-sorted start
    SchemaStore-nvim
    catppuccin-nvim
    mini-nvim
    nui-nvim
    nvim-nio
    nvim-treesitter.withAllGrammars
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
    jj-diffconflicts
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
    toggleterm-nvim
    trouble-nvim
    # keep-sorted end
  ];

  mkPluginPaths = type:
    map (plugin: {
      name = "pack/plugins/${type}/${getName plugin}";
      path = plugin;
    });
  pluginPaths = (mkPluginPaths "start" startPlugins) ++ (mkPluginPaths "opt" optPlugins);
  plugins = linkFarm "snv-plugins" pluginPaths;

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
    fish-lsp
    glsl_analyzer
    graphviz # for crate graph visualtization
    hadolint # docker
    harper
    inotify-tools
    jdt-language-server # java
    just-lsp
    keep-sorted
    koto-ls
    lean4
    lua-language-server
    markdownlint-cli2
    marksman # markdown
    neocmakelsp # cmake
    nil # nix
    prettierd
    python313Packages.debugpy
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

  extraPaths = [
    "${vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter"
  ];

  libs = [sqlite];

  name = "snv" + (optionalString dev "-dev") + (optionalString profile "-profile");

  cmds =
    (
      if dev
      then ["set packpath+=${plugins}"]
      else [
        "set packpath=${plugins},$VIMRUNTIME"
        "set runtimepath=${src},$VIMRUNTIME,${src}/after"
      ]
    )
    ++ [
      "let g:loaded_node_provider=0"
      "let g:loaded_perl_provider=0"
      "let g:loaded_python_provider=0"
      "let g:loaded_python3_provider=0"
      "let g:loaded_ruby_provider=0"
    ];

  initLua = writeTextFile {
    name = "${name}-init.lua";
    destination = "/init.lua";
    text =
      # lua
      ''
        vim.loader.enable()

        ${optionalString profile
          # lua
          ''
            vim.opt.rtp:append("${vimPlugins.snacks-nvim}")
            require("snacks.profiler").startup()
          ''}
      '';
  };
in
  runCommandWith {
    inherit name;
    stdenv = stdenvNoCC;
    runLocal = true;
    derivationArgs = {nativeBuildInputs = [makeWrapper];};
  }
  ''
    makeWrapper ${getExe neovim-unwrapped} $out/bin/${name} \
      --argv0 ${name} \
      --set NVIM_APPNAME ${name} \
      --suffix LD_LIBRARY_PATH : ${makeLibraryPath libs} \
      --suffix PATH : ${makeBinPath packages} \
      --suffix PATH : ${concatStringsSep ":" extraPaths} \
      ${optionalString (!dev) "--add-flags --clean"} \
      --add-flags '-u ${initLua}/init.lua' \
      --add-flags --cmd \
      --add-flag '${concatStringsSep " | " cmds}'
  ''
