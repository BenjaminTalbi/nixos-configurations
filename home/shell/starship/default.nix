{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      character = {
        format = "$symbol "; # The format string used before the text input.
        success_symbol = "[󰅂](bold green)"; # The format string used before the text input if the previous command succeeded.
        error_symbol = "[󰅂](bold red)"; # The format string used before the text input if the previous command failed.
        vimcmd_symbol = "[](bold green)"; # The format string used before the text input if the shell is in vim normal mode.
        vimcmd_replace_one_symbol = "[](bold purple)"; # The format string used before the text input if the shell is in vim replace_one mode.
        vimcmd_replace_symbol = "[](bold purple)"; # The format string used before the text input if the shell is in vim replace mode.
        vimcmd_visual_symbol = "[](bold yellow)"; # The format string used before the text input if the shell is in vim visual mode.
      };
      directory = {
        home_symbol = "🏠";
      };
      aws = {
        disabled = true;
      };
    };
  };
}
