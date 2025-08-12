{ config, pkgs, ... }:
{
  home.packages = with pkgs; [ wofi ];

  xdg.configFile."wofi/config".text = ''
    show=drun
    allow_images=true
    image_size=32
    no_actions=true
    width=800
    height=300
    location=center
    allow_markup=true
    prompt=Run:
    filter_rate=100
    insensitive=true
    term=ghostty
  '';

  xdg.configFile."wofi/style.css".text = ''
    /* Base typography */
    * {
      font-family: Iosevka, sans-serif;
      font-size: 16px;
    }

    /* Window chrome — Hyprland style */
    window {
      margin: 0px;
      border: 2px solid rgba(245, 194, 231, 1);
      border-radius: 10px;
      background-color: #1f1f28;
    }

    /* Search input */
    #input {
      margin: 8px;
      border: none;
      background-color: #2a2a37;
      color: #dcd7ba;
    }

    /* Layout containers */
    #inner-box {
      margin: 8px;
      border: none;
      background-color: #1f1f28; /* sumiInk0 */
    }

    #outer-box {
      margin: 4px;
      border: none;
      background-color: #1f1f28; /* sumiInk0 */
    }

    #scroll {
      margin: 0px;
      border: none;
    }

    #entry {
      padding: 6px 8px;
      border-radius: 6px;
    }

    #entry:selected {
      background-color: #2d4f67; /* waveBlue2 */
      color: #dcd7ba;
    }

    arrow {
      min-width: 0px;
      min-height: 0px;
    }

    #img {
      min-width: 32px; /* = image_size from config */
      min-height: 32px;
      margin: 0 10px 0 6px;
    }

    #text {
      margin: 2px 0;
      color: #dcd7ba;
    }
  '';
}
