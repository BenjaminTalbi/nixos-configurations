{ pkgs, userSettings, ... }:

{
  imports = [
   ../../system/core
  ];

  wsl = {
    enable = true;
    wslConf.automount.root = "/mnt";
    defaultUser = userSettings.username;
    startMenuLaunchers = true;
  };

  security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = [
    (import ./win32yank.nix { inherit pkgs; })
  ];

  # Bootloader.
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 10;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "23.11";
}
