{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    gruvbox-plus-icons
    iosevka
    nerd-fonts.iosevka
    bibata-cursors
    gruvbox-gtk-theme
    gtk-engine-murrine
    gnome-themes-extra
    sassc
  ];

  gtk = {
    enable = true;
    theme = {
      # Use an installed theme name from the package:
      name = "Gruvbox-Dark";         # or "Gruvbox-Dark-BL" (borderless)
      package = pkgs.gruvbox-gtk-theme;
    };
    iconTheme = {
      name = "Gruvbox-Plus-Dark";
      package = pkgs.gruvbox-plus-icons;
    };
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };
  };

  # Consistent cursor
  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  # From Readme
  # If you choose "-BL" etc., update the path accordingly.
  home.file.".config/gtk-4.0" = {
    source = "${pkgs.gruvbox-gtk-theme}/share/themes/Gruvbox-Dark/gtk-4.0";
    recursive = true;
  };
}
