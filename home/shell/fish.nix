{ pkgs, ... }:

{
  programs.fish = {
    enable = false;
    interactiveShellInit = '' 
			set fish_greeting # Disable greeting
            set -gx DIRENV_LOG_FORMAT ""
		'';
    plugins = [
      # import with nixpkgs
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
      { name = "done"; src = pkgs.fishPlugins.done.src; }
      { name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish.src; }
    ];
  };
}
