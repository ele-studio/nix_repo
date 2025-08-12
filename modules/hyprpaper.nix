{ pkgs, ... }:

{
  home.packages = [ pkgs.hyprpaper ];

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ~/Pictures/wallpapers/default.png
    wallpaper = eDP-1,~/Pictures/wallpapers/default.png
    wallpaper = DP-1,~/Pictures/wallpapers/default.png
  '';
}
