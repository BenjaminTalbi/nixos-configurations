{ inputs, pkgs, systemSettings, userSettings, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../system/core
    ../../system/wm/hyprland.nix
    ../../system/stylix
    ../../system/boot/systemd.nix
    ../../system/stylix
    ../../system/security/automount.nix
  ];

  environment.systemPackages = with pkgs; [ 
    google-chrome
  ];
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "23.11";
}
