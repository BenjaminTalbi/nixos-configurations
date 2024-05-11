{ pkgs, inputs, ... }:

{
  imports = [
    # Essentials
    inputs.nixvim.homeManagerModules.nixvim
    ./treesitter.nix
    ./cmp.nix
    ./lsp.nix
    ./telescope.nix

    # Visual 
    ./lualine.nix
    ./indent-blankline.nix
    ./alpha.nix

    # Very useful
    ./comment.nix
    ./fidget.nix
    ./nvim-autopairs.nix

    # Cannot live without
    ./harpoon.nix
    ./oil.nix

    # OK
    ./wilder.nix
    # ./gitsigns.nix

    # Testing
    ./toggleterm.nix
  ];


  programs.nixvim = {
    enable = true;
    vimAlias = true;
    enableMan = true;
    colorscheme = "rose-pine";
    colorschemes = {
      rose-pine = {
        enable = true;
        settings = {
          styles = {
            bold = true;
            italic = true;
            transparency = true;
          };
        };
      };
    };

    opts = {
      background = "dark";
      guicursor = "";
      number = true;
      relativenumber = true;
      tabstop = 4;
      softtabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      wrap = false;
      swapfile = false;
      backup = false;
      undodir = "/tmp/undodir";
      undofile = true;
      hlsearch = false;
      incsearch = true;
      termguicolors = true;
      scrolloff = 8;
      signcolumn = "yes";
      isfname = "@,48-57,/,.,-,_,+,,,#,$,%,~,=,@-@";
      updatetime = 50;
      showtabline = 0;
    };

    globals = {
      mapleader = " ";
    };

    keymaps = [
      {
        action = ":m '>+1<CR>gv=gv";
        key = "J";
        mode = "v";
        options.desc = "Move selection up";
      }
      {
        action = ":m '<-2<CR>gv=gv";
        key = "K";
        mode = "v";
        options.desc = "Move selection down";
      }
      {
        action = "mzJ`z";
        key = "J";
        mode = "n";
        options.desc = "Join but cursor stays put";
      }
      {
        action = "<C-d>zz";
        key = "<C-d>";
        mode = "n";
        options.desc = "Jump down with fixed cursor";
      }
      {
        action = "<C-u>zz";
        key = "<C-u>";
        mode = "n";
        options.desc = "Jump up with fixed cursor";
      }
      {
        action = "nzzzv";
        key = "n";
        mode = "n";
        options.desc = "Next with fixed cursor";
      }
      {
        action = "Nzzzv";
        key = "N";
        mode = "n";
        options.desc = "Previous with fixed cursor";
      }
      {
        action.__raw = "[[\"_dP]]";
        key = "<leader>p";
        mode = "x";
        options.desc = "Paste keep clipboard";
      }
      {
        action.__raw = "[[\"+y]]";
        key = "<leader>y";
        mode = [ "n" "v" ];
        options.desc = "Yank system clipboard";
      }
      {
        action.__raw = "[[\"+Y]]";
        key = "<leader>Y";
        mode = "n";
        options.desc = "Yank system clipboard";
      }
      {
        action.__raw = "[[\"_d]]";
        key = "<leader>d";
        mode = "n";
        options.desc = "Delete to to system clipboard";
      }
      {
        action = "<nop>";
        key = "Q";
        mode = "n";
        options.desc = "Nothing";
      }
      {
        action = "<cmd>Ex<CR>";
        key = "<leader>pv";
        mode = "n";
        options.desc = "Go to file explorer";
      }
    ];

    plugins = {
      # hardtime.enable = true;
      which-key.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [
      dressing-nvim
    ];

    extraPackages = with pkgs; [
      nixpkgs-fmt
      ripgrep
      fd
      bat
    ];

    autoGroups = {
      markdown_conceal = {
        clear = true;
      };
      highlight_yank = {
        clear = true;
      };
    };

    autoCmd = [
      {
        event = [ "FileType" ];
        pattern = [ "markdown" ];
        group = "markdown_conceal";
        command = "setlocal conceallevel=2";
      }
      {
        event = [ "TextYankPost" ];
        desc = "Highlight when yanking text";
        group = "highlight_yank";
        callback.__raw = "function() vim.highlight.on_yank() end";
      }
    ];
  };

}
