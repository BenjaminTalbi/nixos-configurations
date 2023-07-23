{ pkgs, config, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [

      # Completions
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-nvim-lsp-signature-help
      nvim-cmp
      lspkind-nvim
      # vim-vsnip # Check Github
      luasnip     
      nvim-lspconfig
      { 
        plugin = nvim-treesitter.withAllGrammars;
	config = builtins.readFile(./plugins/treesitter.lua);
        type = "lua";
      }
      { 
        plugin = harpoon;
        config = builtins.readFile(./plugins/harpoon.lua);
        type = "lua";
      }
      { 
        plugin = telescope-nvim;
        config = builtins.readFile(./plugins/telescope.lua);
        type = "lua";
      }
      { 
        plugin = undotree;
        config = builtins.readFile(./plugins/undotree.lua);
        type = "lua";
      }
    ];
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
    ];
  };
}
