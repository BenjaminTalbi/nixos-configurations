{ pkgs, inputs, ... }:

{
  home.packages = [ pkgs.inter ];
  services.playerctld.enable = true;
  programs.waybar = {
    enable = true;
    # Overwrite normal waybar with patched one 
    #package = inputs.hyprland.packages.x86_64-linux.waybar-hyprland.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ]; });
    # package = pkgs.waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ]; });
    style = ./styles.css;
    settings = {
      mainBar = {
        layer = "top";
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "wireplumber"
          "backlight"
          "disk"
          "battery"
          "tray"
        ];
        "hyprland/workspaces" = {
          format = "{icon}";
          # format = "{name}";
          on-scroll-up = "hyprctl dispatch workspaces e+1";
          on-scroll-down = "hyprctl dispatch workspaces e-1";
          on-click = "activate";
          format-icons = {
            "1" = "";
            "2" = "";
            "teams" = "󰊻";
            "music" = "";
            "notes" = "";
          };
          persistent-workspaces = {
            "*" = [ 1 2 ];
          };
        };
        backlight = {
          device = "intel_backlight";
          format = "{icon} {percent}%";
          format-icons = [ " " "󱎖 " " " ];
          on-click = "brightnessctl set +10%";
          on-click-right = "brightnessctl set 10%-";
          tooltip-format = "{percent}%";
        };
        battery = {
          states = {
            warning = 33;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" ];
          tooltip-format = "Capacity: {capacity}%\n{timeTo}\nCurrent draw: {power}󱐋";
        };
        # TODO work on calendar
        clock = {
          format = "{:%R %F}";
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
          format = "{max_frequency}% ";
          tooltip-format = "{icon0} {icon1} {icon2} {icon3} {icon4} {icon5} {icon6} {icon7} {icon8} {icon9} {icon10} {icon11}";
        };
        disk = {
          interval = 120;
          #format = "";
          format = "  {free}";
          tooltip-format = "{free}";
        };
        network = {
          format-wifi = "";
          format-ethernet = "󰈁";
          format-disconnected = "󰈂";
          tooltip-format = "{essid}";
        };
        wireplumber = {
          format = "{icon} {volume}%";
          format-icons = [ " " " " " " ];
          format-muted = "󰝟 ";
          on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+";
          on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-";
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          max-volume = 150;
          scroll-step = 0.2;
          tooltip-format = "{node_name} {volume}%";
        };
        tray = {
          icon-size = 18;
          spacing = 3;
        };
      };
    };
  };
}
