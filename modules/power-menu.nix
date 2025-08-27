{ config, pkgs, ... }:

{
  xdg.configFile."wofi/power-style.css".text = ''
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

    * {
      padding: 0;
      margin: 0;
      border: 0;
      border-radius: 0;
      color: @dark;
      font-family: "Roboto Condensed";
      font-weight: 700;
      font-size: 13px;
      box-shadow: none;
      text-shadow: none;
      transition: none;
    }

    window {
      background-color: @dark;
      border-radius: 0;
      padding: 0;
    }

    #outer-box {
      background-color: @dark;
      padding: 14px;
      min-height: 108px;
      margin: 0;
      border: 0;
      border-radius: 0;
    }

    #prompt, #input {
      margin: 0;
      padding: 0;
      min-height: 0;
      max-height: 0;
      border: 0;
      background-color: @transparent;
      color: @transparent;
      caret-color: @transparent;
      box-shadow: none;
      opacity: 0;
    }
    #input image, #prompt image { opacity: 0; }

    #scroll, #inner-box {
      border: 0;
      border-radius: 0;
      background-color: @dark;
      padding: 0;
      margin: 0;
    }

    #entry {
      margin: 0 3px;
      padding: 0 15px;
      min-height: 80px;
      background-color: @green;
      border-radius: 0;
    }

    #text {
      color: inherit;
      margin: 0 auto;
      text-align: center;
    }

    #entry:selected { background-color: @red; }
    #text:selected  { color: inherit; background-color: transparent; }
  '';
}
