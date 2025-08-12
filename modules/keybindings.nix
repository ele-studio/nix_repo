{ config, pkgs, root, ... }:

{
  programs.neovim.enable = true;

  home.file."bin/keybinding.sh" = {
    source = root + "/scripts/keybinding.sh";
    executable = true;
  };
}
