{ inputs, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (final: prev: {
      awesome = (prev.awesome.overrideAttrs (old: {
        src = prev.fetchFromGitHub {
          owner = "awesomeWM";
          repo = "awesome";
          rev = "3a542219f3bf129546ae79eb20e384ea28fa9798";
          sha256 = "1qyy650rwxaakw4hmnvwv7lqxjz22xhbzq8vqlv6ry5g5gmg0gg3";
        };
        patches = [ ];
        GI_TYPELIB_PATH = "${prev.playerctl}/lib/girepository-1.0:"
          + "${prev.upower}/lib/girepository-1.0:"
          + old.GI_TYPELIB_PATH;
      })).override {
        stdenv = prev.clangStdenv;
        gtk3Support = true;
      };
    })
    (self: super: {
      vscodeInsiders =
        inputs.vscodeInsiders.packages.${super.system}.vscodeInsiders;
      firefox-nightly-bin =
        inputs.flake-firefox-nightly.packages.${super.system}.firefox-nightly-bin;
    })
    inputs.powercord-overlay.overlay
    inputs.nur.overlay
    inputs.neovim-nightly-overlay.overlay
  ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  home-manager = {
    # Pass inputs to all home-manager modules
    extraSpecialArgs = { inherit inputs; };
    # Use packages configured by NixOS configuration (overlays & allowUnfree)
    useGlobalPkgs = true;
    users.marshall = {
      imports = [ ../home ];
      home.stateVersion = "22.05";
    };
  };

  systemd = {
    user.services.pipewire-pulse.path = [ pkgs.pulseaudio ];
    services.ssh-agent = {
      enable = true;
      description = "SSH key agent";
      serviceConfig = {
        Type = "simple";
        Environment = "SSH_AUTH_SOCK=%t/ssh-agent.socket";
        ExecStart = "/run/current-system/sw/bin/ssh-agent -D -a $SSH_AUTH_SOCK";
      };
      wantedBy = [ "multi-user.target" ];
    };
  };

  users.users.marshall = {
    isNormalUser = true;
    home = "/home/marshall";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFA12eoS+C+n1Pa1XaygSmx4+CGkO6oYV5bZeSeBU28Y mars@possums.xyz"
    ];
  };

  system.activationScripts = {
    fixVsCodeWriteAsSudo = {
      text = ''
        mkdir -m 0755 -p /bin
        ln -sf "/run/current-system/sw/bin/bash" /bin/.bash.tmp
        mv /bin/.bash.tmp /bin/bash
        ln -sf "/run/wrappers/bin/pkexec" /usr/bin/.pkexec.tmp
        mv /usr/bin/.pkexec.tmp /usr/bin/pkexec
        eval $(/run/current-system/sw/bin/ssh-agent)
      '';
      deps = [ ];
    };
  };

  time.timeZone = "America/New_York";
  security.sudo.wheelNeedsPassword = false;
  programs.dconf.enable = true;
  programs.command-not-found.enable = false;
}
