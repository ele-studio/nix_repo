{ config, pkgs, ... }:
let
  palette = {
    dark       = "#282828";
    red        = "#ea6962";
    red_alt    = "#ca3433";
    orange     = "#e78a4e";
    yellow     = "#d8a657";
    blue       = "#7daea3";
    green      = "#a9a665";
    aqua       = "#89b482";
    cream      = "#d4be98";
    grey       = "#504945";
    dark_grey  = "#181818";
  };
in
{
  home.file.".config/ghostty/config".text = ''
    # Font Configuration
    font-family = "Iosevka Nerd Font Mono"
    window-title-font-family = "Iosevka Nerd Font Mono"
    font-size = 15
    font-thicken = true

    # Window and Appearance
    background-opacity = 0.97
    window-padding-x = 10
    window-padding-y = 10
    window-padding-balance = true

    # Gruvbox-style colors (matched to your Wofi palette)
    background = ${palette.dark}
    foreground = ${palette.cream}
    cursor-color = ${palette.cream}
    selection-background = ${palette.grey}
    selection-foreground = ${palette.dark}

    # Behavior
    cursor-style = block
    copy-on-select = false
    term = xterm-256color
    window-inherit-font-size = false
    gtk-single-instance = true
    shell-integration = none
    window-width = 120
    window-height = 30

    # Keybinds
    keybind = ctrl+plus=increase_font_size:1
    keybind = ctrl+minus=decrease_font_size:1
    keybind = ctrl+0=reset_font_size
    keybind = ctrl+v=paste_from_clipboard
    keybind = ctrl+shift+c=copy_to_clipboard
    keybind = ctrl+shift+v=paste_from_clipboard
    keybind = ctrl+shift+n=new_window
    keybind = ctrl+shift+t=new_tab
    keybind = ctrl+shift+w=close_surface
    keybind = ctrl+tab=next_tab
    keybind = ctrl+shift+tab=previous_tab
    keybind = ctrl+page_down=next_tab
    keybind = ctrl+page_up=previous_tab
    keybind = ctrl+a=select_all
    keybind = ctrl+l=clear_screen
    working-directory = ~
  '';
}
