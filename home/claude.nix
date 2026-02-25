{ lib, config, ... }:

{
  options = {
    claude.enable = lib.mkEnableOption "enable claude config";
  };

  config = lib.mkIf config.claude.enable {
    home.file.".claude" = {
        source = ./claude;
        recursive = true;
    };
  };
}
