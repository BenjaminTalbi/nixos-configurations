{ config, pkgs, inputs, home-manager, ... }:

{
  imports = [ inputs.hyprland.nixosModules.default ];
  programs.hyprland.enable = true;

  home-manager.users.benjamin = {
    imports = [ inputs.hyprland.homeManagerModules.default ];

    services.udiskie.enable = true;


    #TODO extract  
    home.packages = with pkgs; [
      playerctl
      wl-clipboard
      grim # Screenshots
      slurp # Select screen area
      inputs.hyprland-contrib.packages.x86_64-linux.grimblast # Builds on Grim
      hyprpaper # Wallpaper
      libappindicator-gtk3 # Needed for udiskies trayer icon
    ];


    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
      extraConfig = import ./config.nix { };
    };


    xdg.configFile = {
      "hypr/hyprpaper.conf" = {
        source = ./hyprpaper.conf;
      };
      "wallpaper" = {
        source = ../../extras/wallpaper;
        recursive = true;
      };
    };

  };
}
