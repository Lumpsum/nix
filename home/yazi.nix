{ lib, config, ... }:

{

    options = {
        yazi.enable = lib.mkEnableOption "enable yazi";
        yazi.theme = lib.mkOption {
            type = lib.types.str;
            default = "kanagawa";
        };
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
                dark = config.yazi.theme;
                light = config.yazi.theme;
            };
        };
      };
    };
}
