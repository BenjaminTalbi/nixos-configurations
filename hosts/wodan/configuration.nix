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

  services.keyd = {
    enable = true;
    keyboards.default.settings = {
      main = {
        capslock = "overload(custom, esc)";
        rightalt = "oneshot(custom)";
      };
      custom = {
        h = "left";
        k = "up";
        j = "down";
        l = "right";
        a = "macro(compose a \")";
        o = "macro(compose o \")";
        u = "macro(compose u \")";
        s = "macro(compose s s)";
      };
      "custom+shift" = { };
    };
  };
  environment.systemPackages = with pkgs; [
    google-chrome
    keyd
  ];
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "23.11";
}
