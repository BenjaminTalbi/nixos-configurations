{
  programs.nixvim.plugins.alpha =
    let
      buttons.opts = key: {
        shortcut = key;
        position = "center";
        width = 50;
        shrink_margin = true;
        align_shortcut = "right";
      };
    in
    {
      enable = true;
      layout = [
        { type = "padding"; val = 10; }

        {
          type = "text";
          val = [
            "              -.              "
            "        :   .-++-.   :        "
            "     .-=.    :**:    .=-      "
            "    -*=      .**       =*-    "
            "  -**-       .**.       =*+-  "
            " +**+.       .**.       .+**+ "
            "  :+**=.     .**      .=**+:  "
            "    :+**=:   .**    :+**+:    "
            "      :+**+: .**. :+**=.      "
            "        .+**+=**=***=.        "
            "          .=******=.          "
            "           :+****+:           "
            "         -+********+:         "
            "       -***+-.**.-***+-       "
            "     -***+:  .**   :+**+-     "
            "  .-***=:    .**     :=***-.  "
            ".-***=.      .**       .+***- "
            " -+**=.      .**       .=**+: "
            "   :+**=:    .**     :+**+:   "
            "     :+**+:  .**   :+**+:     "
            "       :+**+:.** :+**+:       "
            "         :+**+*****+:         "
            "           :+****=:           "
            "             .==.             "
          ];
          opts = {
            hl = "Type";
            position = "center";
          };
        }

        { type = "padding"; val = 5; }

        {
          type = "group";
          val = [
            {
              on_press.__raw = "function() vim.cmd[[ene]] end";
              opts = buttons.opts "n";
              type = "button";
              val = " New file";
            }
            {
              on_press.__raw = "function() vim.cmd[[qa]] end";
              opts = buttons.opts "q";
              type = "button";
              val = "󰠚 Quit Neovim";
            }
          ];
        }

        { type = "padding"; val = 5; }

        {
          type = "text";
          val = "Treat yourself as a community across time";
          opts = {
            hl = "Keyword";
            position = "center";
          };
        }
        {
          type = "text";
          val = "- Jordan Peterson";
          opts = {
            hl = "Keyword";
            position = "center";
          };
        }

      ];
    };
}
