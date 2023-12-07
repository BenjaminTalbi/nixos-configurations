# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git # Flakes use Git to pull dependencies, so Git must be installed first.
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget # Common util
    curl # Common util
    udiskie # Auto mount USB storage
    grc # For fish shell
    obs-studio
    lazygit # For work
    tidal-hifi
    obsidian


    # Required for sddm 
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtmultimedia
    gst_all_1.gst-plugins-good
    gst_all_1.gst-libav
    gst_all_1.gstreamer

    citrix_workspace
    powertop

    # Personal
    discord
  ];

  services.xserver = {
    enable = true;
    displayManager = {
      sddm.enable = true;
      sddm.theme = "${import ./sddm/sddm-theme.nix { inherit pkgs; }}";
      sddm.settings = {
        General.DisplayServer = "x11-user";
#        Autologin = {
#          User = "benjamin";
#        };
      };
    };
  };

  # Make using swaylock possible
  security.pam.services.swaylock.text = ''
    # PAM configuration file for the swaylock screen locker. By default, it includes
    # the 'login' configuration file (see /etc/pam.d/login)
    auth include login
  '';

  # Editor
  environment.variables.EDITOR = "nvim";

  # Fonts
  fonts = {
    packages = with pkgs; [
      (nerdfonts.override {
        fonts = [
          "FiraCode"
          "IosevkaTerm"
          "Iosevka"
          "Meslo"
          "Mononoki"
          "CodeNewRoman"
        ];
      })
      # font-awesome
    ];
    # enableDefaultFonts = false;
  };

  # Enable bluetooth
  hardware.bluetooth.enable = true;

  # Enable sound with pipewire
  sound.enable = false;
  hardware.pulseaudio.enable = false;
  services.power-profiles-daemon = {
    enable = true; # Check later TODO
  };

  security.polkit.enable = true;

  # OpenSSH daemon
  services = {
    openssh = {
      enable = true;
      settings = {
        X11Forwarding = true;
        PermitRootLogin = "no"; # Disable Root Login
        PasswordAuthentication = false; # Disable password login
      };
      openFirewall = false; # Check later TODO
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    dbus.packages = [ pkgs.gcr ]; # Unsure what this is for TODO
    blueman.enable = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  xdg.portal = {
    enable = true;
    config.common.default = "xdg-desktop-portal-hyprland";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable fish shell
  programs.fish.enable = true;
  programs.ssh.extraConfig = ''
  Host * 
   ForwardAgent yes
  '';
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.benjamin = {
    isNormalUser = true;
    description = "Benjamin";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
    shell = pkgs.bash;
    # TODO Add my public key
    # openssh.authorizedKeys.keys = [ "" ];
  };

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };
  };

  # Bootloader.
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 10;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
