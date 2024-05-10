# My NixOS configs

A few bullet points:
- uses [home-manager standalone with flakes](https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-standalone)
- 

## Frija (WSL)
See the README inside the hosts/frija folder for caveats and installation instructions.


## Rebuild home-manager
```home-manager switch --flake [PATH TO FLAKE.NIX]```

## First time build
### WSL
```sudo nixos-rebuild boot': sudo nixos-rebuild boot --flake /etc/nixos#frija```
### Non-WSL
```sudo nixos-rebuild switch': sudo nixos-rebuild boot --flake /etc/nixos#[HOSTNAME]```
- This will change your username and hostname

## Symlink /etc/nixos
```sh
cd /etc
sudo mv /etc/nixos{,.old}
sudo ln -s /home/[username]/nixos-configurations nixos
```
