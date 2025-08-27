{ config, pkgs, lib, ... }:

{
  imports = [
    ./modules/theme.nix
    ./modules/hyprlock.nix
    ./modules/hypridle.nix
    ./modules/hyprpaper.nix
    ./modules/hyprpicker.nix
    ./modules/hyprshot.nix
    ./modules/auto-start.nix
    ./modules/wofi.nix
    ./modules/waybar.nix
    ./modules/swaync.nix
    ./modules/hyprland-config.nix
    ./modules/neovim.nix
    ./modules/keybindings.nix
    ./modules/ghostty.nix
    ./modules/power-menu.nix
    ./modules/power-script.nix
  ];

  home.stateVersion = "25.05";

  wayland.windowManager.hyprland.enable = true;
}
