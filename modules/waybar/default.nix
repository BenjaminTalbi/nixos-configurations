{ pkgs, ... }:

{
  home.packages = [ pkgs.inter ];
  services.playerctld.enable = true;
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs ( oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ]; });
    settings = {
      mainBar = {
        layer = "top";
        modules-left = [ "wlr/workspaces" ];
        modules-center = [ "wlr/taskbar" ];
        modules-right = [ 
          "pulseaudio" 
          "network#interface" 
          "network#speed" 
          "cpu" 
          "temperature" 
          "backlight" 
          "battery"
          "clock"
          "tray"
        ];
        persistent_workspaces = {
          "1" = [];
          "2" = [];
          "3" = [];
        };
        "wlr/workspaces" = {
           format = "{icon}";
           on-click = "activate";
           sort-by-number = true;
        };
        pulseaudio = {
          format = "{volume}%";
        };
        "network#speed" = {
          format = "up: {bandwidthUpBits} dn: {bandwidthDownBits}";
        };
        "networkinterface" = {
          format-ethernet = "{ifname}";
          format-wifi = "{ifname}";
          tooltip = true;
          tooltip-format = "{ipaddr}";
        };
        cpu = {
            format = "cpu: {usage}% {avg_frequency}";
        };
        temperature = {
          format = "{temperatureC}C";
        };
        backlight = {
          format = "backlight: {percentage}%";
        };
        battery = {
          format = "battery {capacity}%";
        };
        clock = {
          format = "{:%Y-%m-%d %H:%M}";
        };
        tray = {
          icon-size = 16;
          spacing = 8;
        };
      };
    };
  }; 
}
