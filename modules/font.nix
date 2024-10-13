{ pkgs, lib, config, ... }:

{
    options = {
        font.enable = lib.mkEnableOption "enable font";
    };

    config = lib.mkIf config.font.enable {
      # Fonts
      fonts = {
          packages = with pkgs; [
            (nerdfonts.override { fonts = [ "Hack" ]; })
          ];

          fontconfig = {
            defaultFonts = {
              monospace = [ "Hack Nerd Font Mono" ];
              sansSerif = [ "Hack Nerd Font" ];
              serif = [ "Hack Nerd Font" ];
            };
          };
      };
    };
}
