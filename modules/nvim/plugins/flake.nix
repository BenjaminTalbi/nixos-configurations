{ 
    # Use this file to use plugins only available on Github and not the NUR
    inputs = {
        nvim-sqls-src = {
            url = "github:nanotee/sqls.nvim";
            flake = false;
        };
    };

    outputs = inputs: 
        let
            missingVimPluginsInNixpkgs = pkgs: {
                ncim-sqls = pkgs.vimUtils.buildVimPlugin {
                    name = "nvim-sqls";
                    src = inputs.nvim-sqls-src;
                };
            };
        in 
        {
            overlay = _final: prev: {
                vimPlugins = prev.vimPlugins // (missingVimPluginsInNixpkgs prev.pkgs);
            };
        };
}
                
