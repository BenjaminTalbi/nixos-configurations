{ pkgs, config, inputs, ... }:
let
  tailwind-sorter = pkgs.vimUtils.buildVimPlugin {
    name = "tailwind-sorter";
    src = pkgs.fetchFromGitHub {
      owner = "laytan";
      repo = "tailwind-sorter.nvim";
      rev = "efc34952eb0a20520f12c8a273ea44298c11a4fa";
      hash = "sha256-8ywio1EqHc95UyDhG5Xa/xmq5DWILhC33oJ2P7ovAfQ=";
    };
  };
  sqls-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "sqls.vim";
    src = pkgs.fetchFromGitHub {
      owner = "nanotee";
      repo = "sqls.nvim";
      rev = "4b1274b5b44c48ce784aac23747192f5d9d26207";
      hash = "sha256-jKFut6NZAf/eIeIkY7/2EsjsIhvZQKCKAJzeQ6XSr0s=";
    };
  };
  obsidian-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "obsidian-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "epwalsh";
      repo = "obsidian.nvim";
      rev = "ce58193226fa72302ad0732aa61d6a4bec3f0789";
      hash = "sha256-g9GFq5FMaCcJ6HbnhRgCmioLvaJ4SK6jSioDi5lXeP4=";
    };
  };
  harpoon2 = pkgs.vimUtils.buildVimPlugin {
    name = "harpoon2";
    src = pkgs.fetchFromGitHub {
      owner = "ThePrimeagen";
      repo = "harpoon";
      rev = "07cca27cf14a458c469a759c897124f78d953db0";
      hash = "sha256-rVzru/A0Z6PwiEUG0dHv8+KiOz9GYeHllrdSzFZSDM8=";
    };
  };
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      rose-pine
      harpoon2
      telescope-nvim
      nvim-treesitter.withAllGrammars
      nvim-lspconfig

      # lspconfig requirements 
      vim-nix # File type and syntax highlighting.
      luasnip
      nvim-cmp
      cmp_luasnip
      cmp-nvim-lsp
      nvim-lspconfig
      fidget-nvim
      cmp-buffer
      cmp-path
      cmp-nvim-lua

      # From Github
      sqls-nvim
      tailwind-sorter
      obsidian-nvim
      # To consider
      # gitsigns
      # nvim-surround
      # dashboard-nvim
      # nvim-navic
      # nvim-colorizer
      # dressing
      # vim-vsnip # Check Github

      #  nvim-autopairs
      #  # cmp-nvim-lsp-signature-help
      #  nvim-lspconfig
      #  nvim-treesitter-textobjects
      #  {
      #    plugin = Comment;
      #    type = "lua";
      #    config = builtins.readFile(./configurations/comment.lua);
      #  }
      #  { 
      #    plugin = undotree;
      #    config = builtins.readFile(./configurations/undotree.lua);
      #    type = "lua";
      #  }
    ];
    # Extra packages like LSPs
    extraPackages = with pkgs; [
      tree-sitter
      nodejs
      nodePackages.bash-language-server
      lua-language-server
      nil
      nixpkgs-fmt
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      nodePackages.svelte-language-server
      nodePackages."@tailwindcss/language-server"
      ripgrep
      fd
      nil
    ];
  };
  xdg.configFile = {
    "nvim/lua" = {
      source = ./lua;
      recursive = true;
    };
    "nvim/after" = {
      source = ./after;
      recursive = true;
    };
    "nvim/init.lua" = {
      source = ./init.lua;
    };
  };
}
