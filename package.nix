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
  ghostty,
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
  yaml-language-server,
  zls,
  # keep-sorted end
  lib,
  linkFarm,
  makeBinaryWrapper,
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
  inherit (builtins) catAttrs concatStringsSep genericClosure isList;
  inherit (lib.fileset) toSource unions;
  inherit (lib.strings) getName makeBinPath makeLibraryPath;

  inherit (stdenvNoCC.hostPlatform) system;
  buildVimPlugin = attrs: vimUtils.buildVimPlugin ({version = "0.0.0+rev=${attrs.src.shortRev}";} // attrs);

  depsClosure = let
    toItem = d: {
      key = d.outPath;
      value = d;
    };
  in
    plugins:
      catAttrs "value" (genericClosure {
        startSet =
          if isList plugins
          then map toItem plugins
          else [(toItem plugins)];
        operator = item: map toItem (item.value.dependencies or []);
      });

  inherit (self.inputs.blink-pairs.packages.${system}) blink-pairs;
  inherit (self.inputs.fenix.packages.${system}) rust-analyzer;
  # keep-sorted start block=yes
  clasp-nvim = buildVimPlugin {
    pname = "clasp.nvim";
    src = self.inputs.clasp-nvim;
  };
  filler-begone-nvim = buildVimPlugin {
    pname = "filler-begone.nvim";
    src = self.inputs.filler-begone-nvim;
  };
  ghostty' = vimUtils.buildVimPlugin {
    inherit (ghostty) pname version;
    src = ghostty.vim;
  };
  jj-diffconflicts = buildVimPlugin {
    pname = "jj-diffconflicts";
    src = self.inputs.jj-diffconflicts;
  };
  nvim-treesitter = vimPlugins.nvim-treesitter.withAllGrammars;
  nvim-treesitter-runtime = symlinkJoin {
    name = "nvim-treesitter-runtime";
    paths = depsClosure nvim-treesitter;
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
      ghostty'
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
      blink-pairs
      nvim-treesitter-runtime # manually added to rtp in init.lua
      tiny-code-action-nvim
      # keep-sorted end
    ]
    ++ (with vimPlugins; [
      # keep-sorted start
      blink-cmp
      blink-indent
      blink-lib
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
      quicker-nvim
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
    yaml-language-server
    zls # zig
    # keep-sorted end
  ];

  searchPaths = ["${vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter"];

  allLibs = libs ++ extraLibs;
  allOptPlugins = optPlugins ++ extraOptPlugins;
  allPackages = packages ++ extraPackages;
  allSearchPaths = searchPaths ++ extraSearchPaths;
  allStartPlugins = startPlugins ++ extraStartPlugins;

  mkPluginPaths = type:
    map (plugin: {
      name = "pack/plugins/${type}/${getName plugin}";
      path = plugin;
    });
  pluginPaths = (mkPluginPaths "start" allStartPlugins) ++ (mkPluginPaths "opt" allOptPlugins);
  plugins = linkFarm "snv-plugins" pluginPaths;

  inherit (self.inputs.neovim-nightly-overlay.packages.${system}) neovim;
in
  stdenvNoCC.mkDerivation {
    pname = "snv";
    version = "1.0.0";

    strictDeps = true;
    preferLocalBuild = true;

    src = toSource {
      root = ./.;
      fileset = unions [
        ./after
        ./plugin
        ./queries
        ./snippets
        ./init.lua.in
      ];
    };

    nativeBuildInputs = [makeBinaryWrapper];

    env = {
      inherit plugins neovim;
    };

    phases = ["unpackPhase installPhase"];

    installPhase = ''
      mkdir -p $out/share/snv
      substitute ./init.lua.in $out/share/snv/init.lua --subst-var out --subst-var plugins
      ln -s $src $out/share/snv/site

      makeBinaryWrapper $neovim/bin/nvim $out/bin/snv \
        --inherit-argv0 \
        --add-flag -u --add-flag $out/share/snv/init.lua \
        --set NVIM_APPNAME snv \
        --suffix LD_LIBRARY_PATH : ${makeLibraryPath allLibs} \
        --suffix PATH : ${(makeBinPath allPackages)}:${(concatStringsSep ":" allSearchPaths)}
      ln -s $out/bin/snv $out/bin/snv-dev
      ln -s $out/bin/snv $out/bin/snv-profile
    '';

    passthru = {
      inherit neovim rust-analyzer;
      inherit allLibs allOptPlugins allPackages allSearchPaths allStartPlugins;
      vimPlugins = {inherit blink-pairs clasp-nvim filler-begone-nvim jj-diffconflicts nvim-treesitter nvim-treesitter-runtime tiny-code-action-nvim unnest-nvim;};
    };

    meta = {
      homepage = "https://github.com/stefanboca/nvim";
      mainProgram = "snv";
    };
  }
