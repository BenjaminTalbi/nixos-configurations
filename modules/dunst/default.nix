{ pkgs, ... }:

{
  home.packages = [ pkgs.inter ];

  services.dunst = {
    enable = true;
  };
}
