{
  programs.nixvim.plugins = {
    fidget = {
      enable = true;
      progress = {
        display = {
          doneIcon = "💫";
        };
      };
      notification = {
        window = {
          # should resolve black bg
          winblend = 0;
        };
      };
    };
  };
}
