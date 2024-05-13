{ pkgs, lib, ... }:

{
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        term = "foot";
        # TODO font stylix?
      };
      mouse = {
        hide-when-typing = "yes";
      };
      colors = {
        # TODO stylix?
        alpha = lib.mkForce "0.8";
      };
    };
  };
}
