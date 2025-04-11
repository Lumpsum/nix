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
            ashen = ./flavors/ashen;
        };
        theme = {
            flavor = {
                # dark = "kanagawa";
                # light = "kanagawa";
                dark = "ashen";
                light = "ashen";
            };
        };
      };
    };
}
