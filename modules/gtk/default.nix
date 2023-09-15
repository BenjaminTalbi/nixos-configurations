{ pkgs, ... }:

{
  gtk = {
    enable = true;
    theme = {
      name = "rose-pine";
      package = pkgs.rose-pine-gtk-theme;
    };
    #iconTheme = {
    #  name = "Zafiro-icons-Light";
    #  package = pkgs.zafiro-icons;
    #};
    #iconTheme = {
    #  name = "rose-pine";
    #  package = pkgs.rose-pine-icon-theme;
    #};
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "Bibata Original Ice";
      size = 32;
      package = pkgs.bibata-cursors;
    };
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };
}
