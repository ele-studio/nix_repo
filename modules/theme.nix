{ config, pkgs, lib, ... }:

{
  home.packages = lib.mkBefore (with pkgs; [
    papirus-icon-theme
    iosevka
    nerd-fonts.iosevka
  ]);

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
}
