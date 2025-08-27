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
    /* Gruvbox Dark palette */
    @define-color dark        #282828;
    @define-color red         #ea6962;
    @define-color red_alt     #ca3433;
    @define-color orange      #e78a4e;
    @define-color yellow      #d8a657;
    @define-color blue        #7daea3;
    @define-color green       #a9a665;
    @define-color aqua        #89b482;
    @define-color cream       #d4be98;
    @define-color grey        #504945;
    @define-color dark_grey   #181818;
    @define-color transparent rgba(0,0,0,0);

    /* Base typography */
    * {
      font-family: Iosevka, sans-serif;
      font-size: 16px;
    }

    /* Window chrome */
    window {
      margin: 0px;
      border: 2px solid @orange;
      border-radius: 10px;
      background-color: @dark;
    }

    /* Search input */
    #input {
      margin: 8px;
      border: none;
      background-color: @dark_grey;
      color: @cream;
    }

    /* Layout containers */
    #inner-box {
      margin: 8px;
      border: none;
      background-color: @dark;
    }

    #outer-box {
      margin: 4px;
      border: none;
      background-color: @dark;
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
      background-color: @green;
      color: @cream;
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
      color: @cream;
    }
  '';

}
