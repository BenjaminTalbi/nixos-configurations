{ pkgs, ... }:

{
  home.packages = [ pkgs.inter ];
  services.playerctld.enable = true;
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs ( oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ]; });
    style = ./styles.css;
    settings = {
      mainBar = {
        layer = "top";
        modules-left = [ "wlr/workspaces" ];
        modules-center = [ ];
        modules-right = [ ];
          "wlr/workspaces" = {
        };
      };
    };
  }; 
}
