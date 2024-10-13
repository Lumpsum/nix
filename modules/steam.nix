{ pkgs, lib, config, ... }:

{
    options = {
        steam.enable = lib.mkEnableOption "enable steam";
    };

    config = lib.mkIf config.steam.enable {
      # Steam
      programs.steam.enable = true;
      programs.steam.gamescopeSession.enable = true;
      programs.gamemode.enable = true;
    };
}
