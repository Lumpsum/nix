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
        shellWrapperName = "y";
        flavors = {
            kanagawa = ./flavors/kanagawa;
            ashen = ./flavors/ashen;
            monoglow = ./flavors/monoglow;
            gruvbox = ./flavors/gruvbox;
        };
        theme = {
            flavor = if config.yazi.theme == "catppuccin" then {
                dark = "catppuccin-mocha";
                light = "catppuccin-mocha";
            } else {
                dark = config.yazi.theme;
                light = config.yazi.theme;
            };
        };
      };
    };
}

