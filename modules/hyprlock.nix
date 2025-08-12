{ pkgs, config, ... }:

{
  home.packages = [ pkgs.hyprlock ];

  # Optional: create a minimal config for hyprlock
  xdg.configFile."hypr/hyprlock.conf".text = ''
    background {
      monitor =
      path = ~/Pictures/wallpapers/default.png
      blur_passes = 3
      blur_size = 4
      noise = 0.0
      contrast = 0.7
      brightness = 0.82
      vibrancy = 0.2
      vibrancy_darkness = 0.0
    }

    input-field {
      monitor =
      size = 300, 50
      position = 0, 0
      outline_thickness = 5
      dots_size = 0.2
      dots_spacing = 0.2
      dots_center = true
      fade_on_empty = false
      placeholder_text = <span foreground="gray">Password...</span>
      shadow_passes = 2
      shadow_size = 4
    }
  '';
}
