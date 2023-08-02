{ pkgs, ... }:

{
  home.packages = [ pkgs.inter ];
  services.playerctld.enable = true;
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ]; });
    style = ./styles.css;
    settings = {
      mainBar = {
        layer = "top";
        modules-left = [ "wlr/workspaces" ];
        modules-center = [ ];
        modules-right = [
          "clock"
          "disk"
          "wireplumber"
          "backlight"
          "battery"
          "network"
          "tray"
        ];
        "wlr/workspaces" = {
          format = "{icon}";
          on-scroll-up = "hyprctl dispatch workspaces e+1";
          on-scroll-down = "hyprctl dispatch workspaces e-1";
          on-click = "activate";
          format-icons = {
            "1" = " ";
            "2" = " ";
            "3" = "󰊻 ";
            "4" = " ";
          };
          persistent_workspaces = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            #"5" = [];
            #"6" = [];
            #"7" = [];
            #"8" = [];
            #"9" = [];
          };
        };
        backlight = {
          device = "intel_backlight";
          format = "{icon}";
          format-icons = [ "" "󱎖" "" ];
          on-click = "brightnessctl set +10%";
          on-click-right = "brightnessctl set 10%-";
          tooltip-format = "{percent}%";
        };
        battery = {
          states = {
            warning = 40;
            critical = 15;
          };
          format = "{icon}";
          format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" ];
          tooltip-format = "Capacity: {capacity}%\n{timeTo}\nCurrent draw: {power}󱐋";
        };
        bluetooth = {
          format = "󰂯";
          format-connected = "󰂱";
        };
        # TODO work on calendar
        clock = {
          format = "{:%R %D}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "month";
          };
          actions = {
            on-click = "shift_up";
            on-click-right = "shift_down";
          };
        };
        cpu = {
          format = " {max_frequency}%";
          tooltip-format = "{icon0} {icon1} {icon2} {icon3} {icon4} {icon5} {icon6} {icon7} {icon8} {icon9} {icon10} {icon11}";
        };
        disk = {
          interval = 120;
          format = "{free}  ";
        };
        network = {
          format-wifi = " ";
          format-ethernet = "󰈁 ";
          format-disconnected = "󰈂 ";
          tooltip-format = "{essid}";
        };
        wireplumber = {
          format = "{volume}  ";
          format-muted = " ";
          # on-click = "helvum";
          max-volume = 150;
          scroll-step = 0.2;
        };
      };
    };
  };
}
