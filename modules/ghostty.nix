{ config, pkgs, ... }:
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

    # Additional nice features
    cursor-style = block
    # Fixed: no more annoying popups
    copy-on-select = false
    term = xterm-256color

    # Terminal behavior
    window-inherit-font-size = false
    
    # Performance optimizations
    gtk-single-instance = true
    shell-integration = none
    
    # Reduce GPU reallocations
    window-width = 120
    window-height = 30

    # Font size controls
    keybind = ctrl+plus=increase_font_size:1
    keybind = ctrl+minus=decrease_font_size:1
    keybind = ctrl+0=reset_font_size

    # Standard Linux clipboard
    keybind = ctrl+v=paste_from_clipboard
    keybind = ctrl+shift+c=copy_to_clipboard
    keybind = ctrl+shift+v=paste_from_clipboard

    # Window/tab management
    keybind = ctrl+shift+n=new_window
    keybind = ctrl+shift+t=new_tab
    keybind = ctrl+shift+w=close_surface

    # Tab navigation
    keybind = ctrl+tab=next_tab
    keybind = ctrl+shift+tab=previous_tab
    keybind = ctrl+page_down=next_tab
    keybind = ctrl+page_up=previous_tab

    # Select all
    keybind = ctrl+a=select_all

    # Clear screen
    keybind = ctrl+l=clear_screen
    working-directory = ~
  '';
}