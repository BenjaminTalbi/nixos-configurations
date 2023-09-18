{ config, pkgs, ... }:

{
  imports = [
    ../../modules/system.nix
    ./hardware-configuration.nix
  ];
  # https://github.com/NixOS/nixos-hardware/tree/master/framework
  # Run: sudo fwupdmgr update
  # For the nixos hardware framework flake
  services.fwupd.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;
  networking.hostName = "framework"; # Define your hostname.

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];

  # networking.wireless = {
  #   enable = true; # Enables wireless support via wpa_supplicant.
  #   userControlled.enable = true;
  #   networks = {
  #     widepeepoHappy = {
  #       psk = "yfUedmFcRd~^:4=Han6$a=HMuFO%WyuH";
  #     };
  #   };
  # };
}
