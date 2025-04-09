{ lib, config, ... }:

{

    options = {
        yazi.enable = lib.mkEnableOption "enable yazi";
    };

    config = lib.mkIf config.yazi.enable {
      programs.yazi = {
        enable = true;
        enableZshIntegration = true;
        flavors = {
            kanagawa = ./flavors/kanagawa;
        };
        theme = {
            flavor = {
                dark = "kanagawa";
                light = "kanagawa";
            };
        };
      };
    };
}
