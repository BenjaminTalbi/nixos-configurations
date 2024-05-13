{ lib, pkgs, inputs, userSettings, config, ... }:

let
  themePath = "../../themes/${userSettings.theme}/${userSettings.theme}.yaml";
  polarity = lib.removeSuffix "\n" (builtins.readFile (../../themes/${userSettings.theme}/polarity.txt));
  background.url = builtins.readFile ../../themes/${userSettings.theme}/backgroundurl.txt;
  background.sha256 = builtins.readFile ../../themes/${userSettings.theme}/backgroundSha256.txt;
in
{
  imports = [ inputs.stylix.homeManagerModules.stylix ];

  home.file.".currenttheme".text = userSettings.theme;
  stylix.autoEnable = false;
  stylix.polarity = polarity;
  stylix.image = pkgs.fetchurl {
    url = background.url;
    sha256 = background.sha256;
  };
  stylix.base16Scheme = ./${themePath};
  stylix.fonts = {
    monospace = {
      name = userSettings.font.monospace.name;
      package = userSettings.font.monospace.package;
    };
    serif = {
      name = userSettings.font.regular.name;
      package = userSettings.font.regular.package;
    };
    sansSerif = {
      name = userSettings.font.regular.name;
      package = userSettings.font.regular.package;
    };
    emoji = {
      name = "Noto Color Emoji";
      package = pkgs.noto-fonts-emoji-blob-bin;
    };
    sizes = {
      terminal = 18;
      applications = 12;
      popups = 12;
      desktop = 12;
    };
  };

  stylix.targets.foot.enable = true;
  stylix.targets.nixvim = {
    enable = false;
  };

  stylix.targets.waybar.enable = true;
  stylix.targets.tofi.enable = true;
  stylix.targets.zellij.enable = true;
  stylix.targets.fuzzel.enable = true;

  stylix.targets.kde.enable = true;
  stylix.targets.kitty.enable = true;
  stylix.targets.gtk.enable = true;

  home.file.".config/tofi/config".text = '' 
    width = 100%
    height = 100%
    border-width = 0
    outline-width = 0
    padding-left = 35%
    padding-top = 35%
    result-spacing = 25
    num-results = 5
    font = monospace
    background-color = #000A
    prompt-color=${config.lib.stylix.colors.base08}
    selection-color=${config.lib.stylix.colors.base09}
  '';
  home.file.".swaybg-stylix".text = ''
    #!/bin/sh
    swaybg -m fill -i ${config.stylix.image};
  '';
  home.file.".swaybg-stylix".executable = true;
  home.file.".swayidle-stylix".text = ''
    #!/bin/sh
    swaylock_cmd='swaylock --indicator-radius 200 --screenshots --effect-blur 10x10'
    swayidle -w timeout 300 "$swaylock_cmd --fade-in 0.5 --grace 5" \
                timeout 600 'hyprctl dispatch dpms off' \
                resume 'hyprctl dispatch dpms on' \
                before-sleep "$swaylock_cmd"
  '';
  home.file.".swayidle-stylix".executable = true;
  home.file.".config/qt5ct/colors/oomox-current.conf".source = config.lib.stylix.colors {
    template = builtins.readFile ./oomox-current.conf.mustache;
    extension = ".conf";
  };
  home.file.".config/Trolltech.conf".source = config.lib.stylix.colors {
    template = builtins.readFile ./Trolltech.conf.mustache;
    extension = ".conf";
  };
  home.file.".config/kdeglobals".source = config.lib.stylix.colors {
    template = builtins.readFile ./Trolltech.conf.mustache;
    extension = "";
  };
  home.file.".config/qt5ct/qt5ct.conf".text = pkgs.lib.mkBefore (builtins.readFile ./qt5ct.conf);
  home.file.".config/hypr/hyprpaper.conf".text = ''
    preload = ${config.stylix.image}
    wallpaper = ,${config.stylix.image}
  '';
  home.packages = with pkgs; [
    libsForQt5.qt5ct
    pkgs.libsForQt5.breeze-qt5
    libsForQt5.breeze-icons
  ];
  qt = {
    enable = true;
    style.package = pkgs.libsForQt5.breeze-qt5;
    style.name = "breeze-dark";
    platformTheme.name = "kde";
  };
}
