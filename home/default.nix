{ inputs, pkgs, ... }:

{
  imports = [
    ./dunst
    ./gtk
    ./programs/firefox
    ./qt
    ./shell/bash.nix
    ./shell/direnv.nix
    ./shell/fish.nix
    ./shell/starship.nix
    ./shell/tmux.nix
    ./terminal/kitty.nix
    ./terminal/wezterm.nix
    ./waybar
    ./wofi
    # ./nvim
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      # allowUnfreePredicate = (_: true);
    };
  };

  home = {
    stateVersion = "23.05";
    username = "benjamin";
    homeDirectory = "/home/benjamin";

    packages = with pkgs; [
      # Coding
      lazygit
      nodejs_20
      # citrix_workspace
      google-chrome # For web dev

      # CLI
      httpie

      # Productivity
      # obsidian

      # Fun
      discord
      neofetch # On NixOS btw
      tidal-hifi
      obs-studio

      hyprpicker
      xfce.thunar # GUI file manager
      bottom
    ] ++ [
      inputs.nixvim.packages."${builtins.currentSystem}".nvim
    ];
  };

  # Enable home-manager and git
  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
      userName = "Benjamin Talbi";
      userEmail = "b.talbi@live.de";
    };
    keychain = {
      enable = true;
      enableBashIntegration = true;
      keys = [ "id_ed25519" ];
      agents = [ "ssh" ];
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
