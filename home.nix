{ config, pkgs, inputs, ... }:

{

	imports = [
		inputs.hyprland.homeManagerModules.default
		{ wayland.windowManager.hyprland.enable = true; }
		.modules/hyprland
		.modules/nvim
		.modules/firefox
		.modules/dunst
		.modules/waybar
	];

	nixpkgs = {
#		overlays = [ inputs.vim-plugins.overlay ];
		config = {
			allowUnfree = true;
			# Workaround for https://github.com/nix-community/home-manager/issues/2942
			allowUnfreePrdicate = (_: true);
		};
	};

	home.packages = with pkgs; [
		neofetch
		nnn

		zip
		xz
		unzip

		ripgrep
		jq 	# lightweight and flexible command-line JSON processor
		exa
		fzf 	# command-line fuzzy finder

		dnsutils
		which
		tree

		bottom
	];

	programs.starship = { enable = true; settings = { add_newline = false; }; };

	programs.wezterm = { enable = true; };

	programs.fish = {
		enable = true;
		interactiveShellInit = '' 
			set fish_greeting # Disable greeting
		'';
		plugins = [
			# import with nixpkgs
			{ name = "grc"; src = pkgs.fishPlugins.grc.src; }
			{ name = "done"; src = pkgs.fishPlugins.done.src; }
			{ name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish.src; }
		];
	};


	home = {
		stateVersion = "23.05";
		username = "benjamin";
		homeDirectory = "/home/benjamin";
	};

	# Enable home-manager and git
	programs.home-manager.enable = true;
	programs.git = {
		enable = true;
		userName = "Benjamin Talbi";
		userEmail = "b.talbi@live.de";
	};

	# Nicely reload system units when changing configs
	systemd.user.startServices = "sd-switch";  
}
