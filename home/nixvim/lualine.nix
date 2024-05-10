{
  programs.nixvim = {
    plugins.lualine = {
      enable = true;
      globalstatus = true;

      sections = {
        lualine_a = [
          {
            name = "filename";
            extraConfig = {
              path = 1;
            };
          }
        ];
      };
    };
  };
}
