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
            lsp-zero-nvim

            # Completions
              cmp-nvim-lsp
              nvim-cmp
              luasnip
              #cmp-buffer
              #cmp-path
              #cmp-nvim-lua

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
