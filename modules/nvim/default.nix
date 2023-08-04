{ pkgs, config, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      rose-pine
      harpoon
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
