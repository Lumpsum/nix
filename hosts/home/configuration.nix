# Edit this configuration file to define what should be installed on your system.  Help is available in the configuration.nix(5) man page and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{ imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary networking.proxy.default = "http://user:password@proxy:port/"; networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = { LC_ADDRESS = "nl_NL.UTF-8"; LC_IDENTIFICATION = "nl_NL.UTF-8"; LC_MEASUREMENT = "nl_NL.UTF-8"; LC_MONETARY = "nl_NL.UTF-8"; LC_NAME = "nl_NL.UTF-8"; LC_NUMERIC = "nl_NL.UTF-8"; LC_PAPER = "nl_NL.UTF-8"; LC_TELEPHONE = "nl_NL.UTF-8"; LC_TIME = "nl_NL.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable video drivers
  services.xserver.videoDrivers = ["nvidia"];

  # Enable the GNOME Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = { layout = "us"; variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false; security.rtkit.enable = true; services.pipewire = {
    enable = true; alsa.enable = true; alsa.support32Bit = true; pulse.enable = true;
    # If you want to use JACK applications, uncomment this jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default, no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager). services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.zsh.enable = true;
  users.users.lumpsum = { 
      isNormalUser = true; 
      description = "Rick Vergunst"; 
      extraGroups = [ "networkmanager" "wheel" "libvirtd" ]; 
      packages = with pkgs; [];
    shell = pkgs.zsh;
  };
  users.extraUsers.lumpsum.extraGroups = [ "audio" ];

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run: $ nix search wget
  environment.systemPackages = with pkgs; [
  	vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default. 
	wget
	neovim
    gcc
  ];

  font.enable = true;
  nvidia.enable = true;
  steam.enable = true;

  environment.variables = {
	EDITOR = "nvim";
  };

  # Virt manager
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["lumpsum"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  # Stylix
  #stylix = {
  #      enable = true;
  #      image = ./wallpaper.png;
  #      base16Scheme = {
  #          base00 = "1F1F28";
  #          base01 = "2A2A37";
  #          base02 = "223249";
  #          base03 = "727169";
  #          base04 = "C8C093";
  #          base05 = "DCD7BA";
  #          base06 = "938AA9";
  #          base07 = "363646";
  #          base08 = "C34043";
  #          base09 = "FFA066";
  #          base0A = "DCA561";
  #          base0B = "98BB6C";
  #          base0C = "7FB4CA";
  #          base0D = "7E9CD8";
  #          base0E = "957FB8";
  #         base0F = "D27E99";
  #      };
  #      cursor = {
  #          package = pkgs.bibata-cursors;
  #          name = "Bibata-Modern-Ice";
  #      };
  #      fonts = {
            # monospace = {
            #     package = pkgs.nerdfonts.override {fonts = ["Hack"]; };
            #     name = "Hack Nerd Font Mono";
            # };
  #          monospace = {
  #              package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"]; };
  #              name = "JetBrainsMono Nerd Font Mono";
  #          };
  #          serif = config.stylix.fonts.monospace;
  #          sansSerif = config.stylix.fonts.monospace;
            # sansSerif = {
            #     package = pkgs.dejavu_fonts;
            #     name = "DejaVu Sans";
            # };
            # serif = {
            #     package = pkgs.dejavu_fonts;
            #     name = "DejaVu Serif";
            # };
  #      };
  #  };

  # Some programs need SUID wrappers, can be configured further or are started in user sessions. programs.mtr.enable = true; programs.gnupg.agent = {
  #   enable = true; enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon. services.openssh.enable = true;

  # Open ports in the firewall. networking.firewall.allowedTCPPorts = [ ... ]; networking.firewall.allowedUDPPorts = [ ... ]; Or disable the firewall altogether. networking.firewall.enable = false;

  # This value determines the NixOS release from which the default settings for stateful data, like file locations and database versions on your system were taken. It‘s perfectly fine and recommended to leave this value at the release version of the first install of this system. Before changing this value 
  # read the documentation for this option (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
