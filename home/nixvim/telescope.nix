{
  programs.nixvim.plugins.telescope = {
    enable = true;
    settings.defaults = {
      mappings = {
        i =
          let
            actions = "require('telescope.actions')";
          in
          {
            "<C-j>".__raw = "${actions}.move_selection_next";
            "<C-k>".__raw = "${actions}.move_selection_previous";
            "<C-q>".__raw = "${actions}.send_selected_to_qflist + ${actions}.open_qflist";
          };
      };
    };
    keymaps = {
      "<leader>ff" = "find_files";
      "<leader>fr" = "oldfiles";
      "<leader>fw" = "grep_string";
      "<leader>fs" = "live_grep";
      "<C-p>" = "git_files";
    };
    extensions.fzf-native = {
      enable = true;
      settings = {
        fuzzy = true;
        override_file_sorter = true;
      };
    };
  };
}
