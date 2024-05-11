{ inputs, pkgs, systemSettings, userSettings, ... }:

{
  imports = [
   ../../system/core
   ./hardware-configuration.nix
  ];

  environment.systemPackages = with pkgs; [
  ];

  system.stateVersion = "23.11";
}
