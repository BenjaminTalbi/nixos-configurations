{
  programs.nixvim = {
    plugins.telescope = {
      enable = true;
      settings.defaults.mappings = {
        i =
          let
            actions = "require('telescope.actions')";
          in
          {
            "<C-j>" = {
              __raw = "${actions}.move_selection_next";
              desc = "Move to next selection";
            };
            "<C-k>" = {
              __raw = "${actions}.move_selection_previous";
              desc = "Move to previous selection";
            };
            "<C-s>" = {
              __raw = "${actions}.send_selected_to_qflist + ${actions}.open_qflist";
              desc = "Send to quick fix list";
            };
            "<C-q>" = {
              __raw = "${actions}.send_to_qflist + ${actions}.open_qflist";
              desc = "Send to quick fix list";
            };
          };
      };
      keymaps = {
        "<leader>ff" = {
          action = "find_files";
          options.desc = "Find files";
        };
        "<leader>fr" = {
          action = "oldfiles";
          options.desc = "Recently used files";
        };
        "<leader>fw" = {
          action = "grep_string";
          options.desc = "Find word";
        };
        "<leader>fs" = {
          action = "live_grep";
          options.desc = "Find search term";
        };
        "<leader>fp" = {
          action = "git_files";
          options.desc = "Fuzzy search for files tracked by Git";
        };
      };
      extensions.fzf-native = {
        enable = true;
        settings = {
          fuzzy = true;
          override_file_sorter = true;
        };
      };
    };
    keymaps =
      let
        actions = "require('telescope.actions')";
      in
      [
        {
          key = "<leader>fW";
          mode = "n";
          options.desc = "Find WORD";
          action.__raw = ''
            function()
              local word = vim.fn.expand("<cWORD>")
              ${actions}.grep_string({ search = word })
            end
          '';
        }
      ];
  };
}
