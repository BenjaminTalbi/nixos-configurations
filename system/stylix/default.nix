{ lib, pkgs, inputs, userSettings, ... }:

let
  themePath = "../../themes/${userSettings.theme}/${userSettings.theme}.yaml";
  polarity = lib.removeSuffix "\n" (builtins.readFile (../../themes/${userSettings.theme}/polarity.txt));
  background.url = builtins.readFile ../../themes/${userSettings.theme}/backgroundurl.txt;
  background.sha256 = builtins.readFile ../../themes/${userSettings.theme}/backgroundSha256.txt;
in
{
  imports = [ inputs.stylix.nixosModules.stylix ];

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
  };

  stylix.targets.console.enable = true;

  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };
}
