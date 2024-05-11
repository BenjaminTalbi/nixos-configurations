{ config, pkgs, ... }:

{
  import = [
    ./pipewire.nix
    ./dbus.nix
    ./gnome-keyring.nix
    ./fonts.nix
  ];

  environment.systemPackages = with pkgs; [
    wayland
  ];

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
    # TODO displayManager.sddm here
  };
}
