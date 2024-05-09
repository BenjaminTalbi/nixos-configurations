{ config, pkgs, ... }:

{
  # Patch kernel like this
  # boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.consoleLogLevel = 0;
}
