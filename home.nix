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
  ];

  home.file."debug-home-manager-loaded".text = "yep, it's loaded!";

  home.stateVersion = "25.05";

  wayland.windowManager.hyprland.enable = true;
}
