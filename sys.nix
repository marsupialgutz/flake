{
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [./services/yabai.nix];

  security.pam.enableSudoTouchIdAuth = true;
  services.nix-daemon.enable = true;

  networking = {
    computerName = "MacBook Air";
    hostName = "canis";
  };

  environment.variables.FLAKE = "/Users/marshall/nix-config";

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      font-awesome
      inter
      maple-mono
      monocraft
      nerdfonts
      victor-mono
    ];
  };

  nix = {
    gc = {
      automatic = true;
      interval.Day = 7;
    };

    daemonIOLowPriority = true;
    daemonProcessType = "Adaptive";
    distributedBuilds = true;
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
    registry = lib.mapAttrs (_: v: {flake = v;}) inputs;

    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
      extra-experimental-features = "nix-command flakes";
      flake-registry = "/etc/nix/registry.json";
      keep-derivations = true;
      keep-outputs = true;
      max-jobs = "auto";
      warn-dirty = false;

      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://cache.iog.io"
      ];

      trusted-substituters = [
        "cache.nixos.org"
        "nix-community.cachix.org"
        "cache.iog.io"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      ];

      trusted-users = ["marshall"];
    };
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    useGlobalPkgs = true;
    backupFileExtension = "bak";

    users.marshall = {...}: {imports = [./home.nix];};
  };

  homebrew = {
    enable = true;

    onActivation = {
      cleanup = "none";
      upgrade = true;
      autoUpdate = true;
    };

    brews = [
      {
        name = "felixkratz/formulae/fyabai";
        args = ["HEAD"];
      }
      "jj"
      "libiconv"
      "pinentry-mac"
      "rustup-init"
    ];

    casks = [
      "balenaetcher"
      "beaver-notes-arm"
      "datweatherdoe"
      "devtoys"
      "doll"
      "gpg-suite"
      "jetbrains-toolbox" # Imperative IDE installs because of github copilot
      "launchcontrol"
      "neovide"
      "ngrok"
      "qlcolorcode"
      "qlimagesize"
      "qlmarkdown"
      "qlstephen"
      "qlvideo"
      "quicklook-csv"
      "quicklook-json"
      "quicklookase"
      "sf-symbols"
      "slimhud"
      "spaceid"
      "suspicious-package"
      "telegram"
      "ubersicht"
      "unnaturalscrollwheels"
      "utm-beta"
      "zerotier-one"
    ];

    taps = [
      "DamascenoRafael/tap"
      "Daniele-rolli/homebrew-beaver"
      "FelixKratz/formulae"
      "homebrew/cask-drivers"
      "homebrew/cask-fonts"
      "homebrew/cask-versions"
      "homebrew/services"
    ];
  };

  programs = {
    nix-index.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  nixpkgs.config.allowUnfree = true;

  system = {
    keyboard.enableKeyMapping = true;

    defaults = {
      NSGlobalDomain = {
        KeyRepeat = 1;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
      };

      dock = {
        autohide = true;
        autohide-delay = 1000.0;
        expose-animation-duration = 0.0;
        orientation = "bottom";
        showhidden = true;
        tilesize = 48;
      };
    };
  };

  users.users.marshall = {
    name = "marshall";
    home = "/Users/marshall";
  };

  documentation.enable = false;
}
