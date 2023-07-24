{ config, pkgs, inputs, ...  }:

{ 
  imports = [
    ../waybar.nix
    ../dunst.nix
  ];
    
  //TODO extract  
  home.packages = with pkgs; [ 
    playerctl 
    wl-clipboard 
    grim 
    slurp
    inputs.hyprland-contrib.packages.x86_64-linux.grimblast
    wofi-emoji
  ];

  programs.wofi.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = import ./config.nix {};
  };
}
