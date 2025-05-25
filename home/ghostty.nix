{ lib, config, ... }:

{

  options = {
    ghostty.enable = lib.mkEnableOption "enable ghostty config";
    ghostty.mac = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    ghostty.theme = lib.mkOption {
      type = lib.types.str;
      default = "kanagawa";
    };
  };

  config = lib.mkIf config.ghostty.enable {
    home =
      if config.ghostty.mac == true then
        {
          file."${config.xdg.configHome}/ghostty/themes" = {
            source = ./ghostty/themes;
            recursive = true;
          };

          file."${config.xdg.configHome}/ghostty/config" = {
            source = builtins.toFile "test.txt" "font-family = JetBrains Mono
font-size = 20

cursor-style = bar

theme = ${
              if config.ghostty.theme == "kanagawa" then
                "Kanagawa Wave"
              else if config.ghostty.theme == "ashen" then
                "ashen"
              else if config.ghostty.theme == "monoglow" then
                "monoglow"
              else
                abort "invalid ghostty theme"
            }";
          };
        }
      else
        {
          file."${config.xdg.configHome}/ghostty/themes" = {
            source = ./ghostty/themes;
            recursive = true;
          };

          file."${config.xdg.configHome}/ghostty/config" = {
            source = builtins.toFile "test.txt" "font-family = JetBrains Mono
font-size = 20

cursor-style = bar

theme = ${
              if config.ghostty.theme == "kanagawa" then
                "Kanagawa Wave"
              else if config.ghostty.theme == "ashen" then
                "ashen"
              else if config.ghostty.theme == "monoglow" then
                "monoglow"
              else
                abort "invalid ghostty theme"
            }";
          };
        };
  };
}
