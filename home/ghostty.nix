{ lib, config, ... }:

{

    options = {
        ghostty.enable = lib.mkEnableOption "enable ghostty config";
        ghostty.mac = lib.mkOption {
            type = lib.types.bool;
            default = false;
        };
    };

    config = lib.mkIf config.ghostty.enable {
        home = if config.ghostty.mac == true then {
            file."${config.xdg.configHome}/ghostty/themes" = {
                source = ./ghostty/themes;
                recursive = true;
            };

            file."${config.xdg.configHome}/ghostty/config" = {
                source = builtins.toFile "test.txt" "font-family = JetBrains Mono
font-size = 20

cursor-style = bar

theme = Kanagawa Wave";
            };
            } else {};
    };
}
