{ inputs, pkgs, systemSettings, userSettings, ... }:

{
  imports = [ ];

  wsl = {
    enable = true;
    wslConf.automount.root = "/mnt";
    defaultUser = userSettings.username;
    startMenuLaunchers = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Ensure nix flakes are enabled
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  networking.hostName = systemSettings.hostname;

  # Timezone & Locale  
  time.timeZone = systemSettings.timezone;

  i18n.defaultLocale = systemSettings.locale;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = systemSettings.locale;
    LC_IDENTIFICATION = systemSettings.locale;
    LC_MEASUREMENT = systemSettings.locale;
    LC_MONETARY = systemSettings.locale;
    LC_NAME = systemSettings.locale;
    LC_NUMERIC = systemSettings.locale;
    LC_PAPER = systemSettings.locale;
    LC_TELEPHONE = systemSettings.locale;
    LC_TIME = systemSettings.locale;
  };

  programs.fish.enable = true;

  # User account
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    packages = with pkgs; [ ];
    uid = 1000;
  };

  security.sudo.wheelNeedsPassword = false;

  environment.enableAllTerminfo = true;

  environment.systemPackages = with pkgs; [
    (import ./win32yank.nix { inherit pkgs; })
    vim
    wget
    git
    home-manager
  ];

  system.stateVersion = "23.11";
}
