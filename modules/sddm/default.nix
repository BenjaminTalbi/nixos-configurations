{pkgs, lib, ...}:

{

  environment.systemPackages = with pkgs; [
    # Required for sddm 
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtmultimedia
    gst_all_1.gst-plugins-good
    gst_all_1.gst-libav
    gst_all_1.gstreamer

  ];

  services.xserver = {
    enable = lib.mkForce true;
    displayManager = {
      sddm.enable = true;
      sddm.theme = "${import ./sddm-theme.nix { inherit pkgs; }}";
      sddm.settings = {
        General.DisplayServer = "x11-user";
        # Autologin = {
        #   User = "benjamin";
        # };
      };
    };
  };
}
