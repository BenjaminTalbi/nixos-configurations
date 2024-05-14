{ config, pkgs, userSettings, ... }:

{
  home.username = userSettings.username;
  home.homeDirectory = "/home/${userSettings.username}";

  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "Benjamin Talbi";
    userEmail = "b.talbi@live.de";
  };

  imports = [
    ../../home/shared/packages.nix
    ../../home/nixvim
    ../../home/shell
    ../../user/wm/hyprland/hyprland.nix
    ../../user/stylix
  ];

  home.stateVersion = "23.11";

  home.sessionVariables = {
    EDITOR = userSettings.editor;
  };

  home.packages = with pkgs; [ 
    firefox
    discord
  ];

  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    music = "${config.home.homeDirectory}/Media/Music";
    videos = "${config.home.homeDirectory}/Media/Videos";
    pictures = "${config.home.homeDirectory}/Media/Pictures";
    templates = "${config.home.homeDirectory}/Templates";
    download = "${config.home.homeDirectory}/Downloads";
    documents = "${config.home.homeDirectory}/Documents";
    desktop = null;
    publicShare = null;
    extraConfig = {
      XDG_DOTFILES_DIR = "${config.home.homeDirectory}/.dotfiles";
    };
  };
  xdg.mime.enable = true;
  xdg.mimeApps.enable = true;

}
