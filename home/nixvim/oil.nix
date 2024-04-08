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
        key = "<leader>O";
      }
      {
        action = ":Oil --float<CR>";
        key = "<leader>o";
      }
    ];
  };
}
