{
  programs.nixvim = {
    plugins.oil = {
      enable = true;
      settings = {
        view_options.show_hidden = true;
      };
    };
    keymaps = [
      {
        action = ":Oil<CR>";
        key = "<leader>o";
        options.desc = "Open file manager";
      }
      {
        action = ":Oil --float<CR>";
        key = "<leader>O";
        options.desc = "Open file manager (floating)";
      }
    ];
  };
}
