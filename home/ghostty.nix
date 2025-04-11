{ lib, config, ... }:

{

    options = {
        ghostty.enable = lib.mkEnableOption "enable ghostty config";
    };

    config = lib.mkIf config.ghostty.enable {
        home.file."${config.xdg.configHome}/ghostty/themes" = {
            source = ./ghostty/themes;
            recursive = true;
        };

        home.file."${config.xdg.configHome}/ghostty/config" = {
            source = builtins.toFile "test.txt" "font-family = JetBrains Mono
font-size = 20

cursor-style = bar

theme = ashen";
        };
    };
}
