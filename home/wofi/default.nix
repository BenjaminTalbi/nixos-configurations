{ config, pkgs, inputs, ... }:

{
  imports = [ ];

  # Anything relevant to wofi but not other modules  
  home.packages = with pkgs; [
    wofi-emoji
  ];

  programs.wofi = {
    enable = true;
  };

  xdg.configFile = {
    "wofi/style.css" = {
      source = ./rose-pine.css;
    };
  };

}
