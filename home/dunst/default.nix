{ pkgs, ... }:

{
  home.packages = [ pkgs.inter ];

  services.dunst = {
    enable = true;
    settings = {
      global = {
        font = "Menli Nerd Font 14.0";
        width = 450;
        frame_width = 1;
        notification_limit = 10;
        origin = "top-right";
        progress_bar = false;
        corner_radius = 10;
        frame_color = "#aaaaaa00";
        separator_color = "#aaaaaa00";
        padding = 30;
        horizontal_padding = 15;
      };
      urgency_low = {
        frame_color = "#908caa";
        background = "#191724";
        foreground = "#e0def4";
        highlight = "#f6c177";
        timeout = 3;
      };
      urgency_normal = {
        frame_color = "#ebbcba";
        background = "#191724";
        foreground = "#e0def4";
        highlight = "#f6c177";
        timeout = 10;
      };
      urgency_critical = {
        frame_color = "#eb6f92";
        background = "#191724";
        foreground = "#f6c177";
        timeout = 0;
      };
    };
  };
}
