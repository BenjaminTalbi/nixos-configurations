{
  programs.nixvim.plugins.gitsigns = {
    enable = true;
    settings = {
      signs = {
        add = {
          text = "│";
        };
        change = {
          text = "│";
        };
        changedelete = {
          text = "~";
        };
        delete = {
          text = "_";
        };
        topdelete = {
          text = "‾";
        };
        untracked = {
          text = "┆";
        };
      };
      watch_gitdir = {
        follow_files = true;
      };
      auto_attach = true;
      current_line_blame = false;
      current_line_blame_opts = {
        virt_text = true;
        virt_text_pos = "eol";
        delay = 1000;
        ignore_whitespace = false;
        virt_text_priority = 100;
      };
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>";
      current_line_blame_formatter_opts = {
        relative_time = true;
      };
      sign_priority = 6;
      update_debounce = 100;
      max_file_length = 40000;
      preview_config = {
        border = "single";
        style = "minimal";
        relative = "cursor";
        row = 0;
        col = 1;
      };
    };
  };
}
