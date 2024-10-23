{ pkgs, lib, config, ... }:

{
    options = {
        nvidia.enable = lib.mkEnableOption "enable nvidia";
    };

    config = lib.mkIf config.nvidia.enable {
      # Enable OpenGL
      # hardware.graphics.enable = true;
        services.xserver.videoDrivers = [ "nvidia" ];
        hardware.graphics = {
            enable = true;
        };

      hardware.nvidia = {
        modesetting.enable = true;
        open = false;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.production;
        # package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        #     version = "550.120";
        #     sha256_64bit = "sha256-gBkoJ0dTzM52JwmOoHjMNwcN2uBN46oIRZHAX8cDVpc=";
        #     sha256_aarch64 = "sha256-gBkoJ0dTzM52JwmOoHjMNwcN2uBN46oIRZHAX8cDVpc=";
        #     openSha256 = "sha256-fPfIPwpIijoUpNlAUt9C8EeXR5In633qnlelL+btGbU=";
        #     settingsSha256 = "sha256-fPfIPwpIijoUpNlAUt9C8EeXR5In633qnlelL+btGbU=";
        #     persistencedSha256 = lib.fakeSha256;
        # };
      };
    };
}
