{ inputs, pkgs, systemSettings, userSettings, ... }:

{
  imports = [
   ./hardware-configuration.nix
   ../../system/core
   ../../system/wm/hyprland.nix
   ../../system/stylix
   ../../system/boot/grub.nix
  ];

  environment.systemPackages = with pkgs; [
  ];

  system.stateVersion = "23.11";
}
