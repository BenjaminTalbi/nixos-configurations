{ pkgs, inputs, ... }: 

let 
  nurNoPkgs = import inputs.nur { inherit pkgs; nurpkgs = pkgs; };
in
{
  programs.firefox = {
    enable = true;
    profiles.benjamin = {
      extensions = with nurNoPkgs.repos.rycee.firefox-addons; [
        ublock-origin
        bitwarden
        istilldontcareaboutcookies        
      ];
      settings = {
        browser.startup.homepage = "https://www.google.de";
        signon.rememberSignons = false;
      };
      isDefault = true;
      
    };
  };
}
