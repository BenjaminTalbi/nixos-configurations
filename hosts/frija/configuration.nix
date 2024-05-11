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

  system.stateVersion = "23.11";
}
