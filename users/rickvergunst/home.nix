{
  config,
  pkgs,
  inputs,
  nvim-nix,
  ...
}@extra:
let
  oldnvim = nvim-nix.packages.aarch64-darwin.default;

  inherit (oldnvim.passthru) utils;
  nvim = oldnvim.override (prev: {
    name = "nvim";
    packageDefinitions = prev.packageDefinitions // {
      nvim = utils.mergeCatDefs prev.packageDefinitions.nvim (
        { pkgs, ... }:
        {
          categories = {
            colorscheme = extra.theme;
          };
        }
      );
    };
  });
in
{
  imports = [
    ../../home
    inputs.sops-nix.homeManagerModules.sops
  ];

  # fix from https://github.com/Mic92/sops-nix/issues/890
  launchd.agents.sops-nix = pkgs.lib.mkIf pkgs.stdenv.isDarwin {
    enable = true;
    config = {
      EnvironmentVariables = {
        PATH = pkgs.lib.mkForce "/usr/bin:/bin:/usr/sbin:/sbin";
        SOPS_AGE_KEY_FILE = "/Users/rickvergunst/Library/Application Support/sops/age/keys.txt";
      };
    };
  };

  sops = {
    age.keyFile = "/Users/rickvergunst/Library/Application Support/sops/age/keys.txt";

    defaultSopsFile = ../../secrets.yaml;
    defaultSopsFormat = "yaml";

    secrets.gemini_key = { };
    secrets.chatgpt_key = { };
    secrets.claude_code_key = { };
  };

  home.username = "rickvergunst";
  home.stateVersion = "24.11";
  home.homeDirectory = "/Users/rickvergunst";

  home.packages = [
    pkgs.zoxide
    pkgs.fd
    pkgs.google-cloud-sdk
    pkgs.dive
    pkgs.cue
    pkgs.fzf
    pkgs.httpie
    pkgs.lazygit
    pkgs.kind
    pkgs.opentofu
    pkgs.ripgrep
    pkgs.tmux
    pkgs.watch
    pkgs.pipx
    pkgs.starship
    pkgs.go
    pkgs.oh-my-posh
    pkgs.uv
    pkgs.eza
    pkgs.direnv
    pkgs.podman
    pkgs.utm
    pkgs.firefox
    pkgs.age
    pkgs.sops
    pkgs.claude-code
    nvim
  ];

  programs.git = {
    enable = true;
    settings.user = {
      name = "Lumpsum";
      email = "vergunstje@hotmail.com";
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "zen-browser";
  };

  k9s.enable = true;
  yazi = {
    enable = true;
    theme = extra.theme;
  };

  zshrc.enable = true;

  # wezterm = {
  #     enable = true;
  #     mac = true;
  #     theme = extra.theme;
  # };
  tmux = {
    enable = true;
    theme = extra.theme;
  };
  ohmyposh = {
    enable = true;
    theme = extra.theme;
  };
  ghostty = {
    enable = true;
    mac = true;
    theme = extra.theme;
  };

  programs.home-manager.enable = true;
}
