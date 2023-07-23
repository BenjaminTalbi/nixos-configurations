{ config, pkgs, ...}:

{
  imports = [
    ../../modules/system.nix
    ./hardware-configuration.nix
  ];
  
  # Enable networking
  # networking.networkmanager.enable = true;
  networking.hostName = "framework"; # Define your hostname.
  networking.wireless = {
    enable = true; # Enables wireless support via wpa_supplicant.
    userControlled.enable = true;
    networks = {
        widepeepoHappy = {
           psk = "yfUedmFcRd~^:4=Han6$a=HMuFO%WyuH";
        };
    };
  };
}
