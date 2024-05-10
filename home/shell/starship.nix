{ ... }:
{
  programs = {
    starship = {
      enable = true;
      settings = {
        add_newline = false;
        format = ''
          $directory
          $nix_shell$character
        '';
        right_format = "$all";
        aws.enable = false;
        character = rec {
          error_symbol = "[💥](red)";
          vimcmd_replace_symbol = "[](hotpink)";
          vimcmd_replace_one_symbol = vimcmd_replace_symbol;
          vimcmd_visual_symbol = vimcmd_replace_symbol;
          vimcmd_symbol = "[](blue)";
          success_symbol = "[](bold green)";
        };
        directory = {
          truncation_length = 5;
          truncation_symbol = "../";
          home_symbol = "🪴";
        };
        # TODO [direnv module](https://starship.rs/config/#direnv)
        git_branch = {
          symbol = "";
          truncation_length = 4;
          truncation_symbol = "";
          ignore_branches = [ "master" "main" ];
        };
        git_commit = {
          tag_symbol = "🔖";
        };
      };
    };
  };
}
