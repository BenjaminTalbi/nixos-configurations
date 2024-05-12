{ inputs, pkgs, systemSettings, userSettings, ... }:

{
  imports = [
   ./hardware-configuration.nix
   ../../system/core
   ../../system/wm/hyprland.nix
   ../../system/stylix
   ../../system/boot/virtualbox.nix
    ../../system/stylix
  ];

  # environment.systemPackages = with pkgs; [ ];

  system.stateVersion = "23.11";
}
