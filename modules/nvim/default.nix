{ pkgs, config, ... }:

{
    programs.neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;
        # extraConfig = ''
        #   luafile ${builtins.toString ./init_lua.lua}
        # '';
        extraLuaConfig = ''
            vim.opt.guicursor = ""

            vim.opt.nu = true
            vim.opt.relativenumber = true

            vim.opt.tabstop = 4
            vim.opt.softtabstop = 4
            vim.opt.shiftwidth = 4
            vim.opt.expandtab = true

            vim.opt.smartindent = true

            vim.opt.wrap = false

            vim.opt.swapfile = false
            vim.opt.backup = false
            vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
            vim.opt.undofile = true

            vim.opt.hlsearch = false
            vim.opt.incsearch = true

            vim.opt.termguicolors = true

            vim.opt.scrolloff = 8
            vim.opt.signcolumn = "yes"
            vim.opt.isfname:append("@-@")

            vim.opt.updatetime = 50

            --vim.opt.colorcolumn = "80"

            -- REMAP
            vim.g.mapleader = " "
            vim.keymap.set("n", "<leader>pv", vim.cmd.Ex) -- Go to files

            vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")  -- Move selection up
            vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")  -- Move selection down

            vim.keymap.set("n", "J", "mzJ`z")             --Cursor stays in place when joining
            vim.keymap.set("n", "<C-d>", "<C-d>zz")       -- Jump down / Fixed cursor
            vim.keymap.set("n", "<C-u>", "<C-u>zz")
            vim.keymap.set("n", "n", "nzzzv")             -- Next / Fixed cursor
            vim.keymap.set("n", "N", "Nzzzv")

            -- greatest remap ever
            vim.keymap.set("x", "<leader>p", [["_dP]]) -- Paste keep clipboard

            -- next greatest remap ever : asbjornHaland
            vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]]) -- yank system clip board
            vim.keymap.set("n", "<leader>Y", [["+Y]])        -- yank system clipboard

            vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]]) -- delete to system clipboard

            vim.keymap.set("n", "Q", "<nop>")
            vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
            vim.keymap.set("n", "<leader>f", vim.lsp.buf.format) -- format

            -- Look up quick fix navigation
            vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
            vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
            vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
            vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

            vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
            vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
            vim.keymap.set("n", "<leader>xn", "<cmd>!chmod -x %<CR>", { silent = true })

            vim.keymap.set("n", "<leader>h", ':Rg "vim.keymap.set\\|cmp.mapping" ~/.config/nvim')

            local builtin = require('telescope.builtin')
            vim.keymap.set("n", "<leader>pw", builtin.grep_string, {}) -- Search for word under cursor
            '';
        plugins = with pkgs.vimPlugins; [
# To consider
# gitsigns
# nvim-surround
# dashboard-nvim
# nvim-navic
# nvim-colorizer
# dressing
# vim-vsnip # Check Github

# Completions
#  cmp-nvim-lsp
#  cmp-buffer
#  cmp-path
#  cmp-nvim-lsp
#  cmp-nvim-lua
#  cmp_luasnip
#  nvim-autopairs
#  # cmp-nvim-lsp-signature-help
#  nvim-lspconfig
#  nvim-treesitter-textobjects
#  { 
#    plugin = nvim-treesitter.withAllGrammars;
#    config = builtins.readFile(./configurations/treesitter.lua);
#    type = "lua";
#  }
#  { 
#    plugin = harpoon;
#    config = builtins.readFile(./configurations/harpoon.lua);
#    type = "lua";
#  }
#  {
#    plugin = Comment;
#    type = "lua";
#    config = builtins.readFile(./configurations/comment.lua);
#  }
         telescope-nvim
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
        "nvim/init_lua.lua" = {
            source = ./init_lua.lua;
        };
    };
}
