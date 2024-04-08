{
  programs.nixvim.plugins.obsidian = {
    settings.workspaces = [{ name = "work"; path = "~/obsidian/work"; }];
    enable = true;
  };
}
