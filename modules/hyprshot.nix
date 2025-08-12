{ pkgs, ... }:

{
  home.packages = [ pkgs.hyprshot ];

  xdg.configFile."hypr/hyprshot.conf".text = ''
    save_dir = ~/Pictures
    format = png
    show_notifications = true
    copy_output = true
  '';
}
