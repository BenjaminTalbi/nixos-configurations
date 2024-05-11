{ inputs, pkgs, systemSettings, userSettings, ... }:

{
  imports = [
   ../../system/core
   ./hardware-configuration.nix
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
