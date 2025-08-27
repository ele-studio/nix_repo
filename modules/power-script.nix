{ config, pkgs, root, ... }:

{
  programs.neovim.enable = true;

  home.file."bin/power.sh" = {
    source = root + "/scripts/custom/power.sh";
    executable = true;
  };
}
