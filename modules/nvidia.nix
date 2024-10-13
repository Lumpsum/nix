{ pkgs, lib, config, ... }:

{
    options = {
        nvidia.enable = lib.mkEnableOption "enable nvidia";
    };

    config = lib.mkIf config.nvidia.enable {
      # Enable OpenGL
      hardware.graphics.enable = true;

      hardware.nvidia = {
        modesetting.enable = true;
        open = false;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.production;
      };
    };
}
