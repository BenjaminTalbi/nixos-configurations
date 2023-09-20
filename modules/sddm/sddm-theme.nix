{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "sddm-theme";
  src = pkgs.fetchFromGitHub {
    repo = "aerial-sddm-theme";
    owner = "3ximus";
    rev = "2d0b631e73f2a6479fb72655de65c74054ac2846";
    sha256 = "03ili85c8dm7ailg3qjg10v4x5lc62l0yhcznzgw8z8g7k03fd9z";
  };
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
  '';
}
