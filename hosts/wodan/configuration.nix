{ inputs, pkgs, systemSettings, userSettings, ... }:

{
  imports = [
   ./hardware-configuration.nix
   ../../system/core
   ../../system/wm/hyprland.nix
   ../../system/stylix
  ];

  environment.systemPackages = with pkgs; [
  ];

  
  # Bootloader.
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 10;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "23.11";
}
