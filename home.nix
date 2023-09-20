{ inputs, config, pkgs, lib, ... }:

{
  imports = [
    inputs.hyprland.homeManagerModules.default
    ./modules/hyprland
    ./modules/nvim
    ./modules/firefox
    ./modules/dunst
    ./modules/waybar
    ./modules/terminal
    ./modules/gtk
    ./modules/wofi
    ./modules/qt
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      # allowUnfreePredicate = (_: true);
    };
  };

  home.packages = with pkgs; [
    neofetch # On NixOS btw
    xfce.thunar # GUI file manager
    nnn # Terminal file manager
    google-chrome # For web dev
    pavucontrol # GUI for sound levels
    brightnessctl # Control screen brightness

    zip
    xz
    unzip

    ripgrep
    jq # lightweight and flexible command-line JSON processor
    fzf # command-line fuzzy finder

    dnsutils
    which
    tree

    bottom
  ];


  home = {
    stateVersion = "23.05";
    username = "benjamin";
    homeDirectory = "/home/benjamin";
  };

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "Benjamin Talbi";
    userEmail = "b.talbi@live.de";
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
