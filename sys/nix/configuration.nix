{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
with lib; {
  disabledModules = ["services/hardware/udev.nix"];

  imports = [
    ./hardware-configuration.nix
    ../generic.nix
    ../patches/udev.nix
  ];

  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        version = 2;
      };
    };

    kernelParams = ["module_blacklist=i915"];
    kernelPackages = pkgs.linuxPackages_zen;
    extraModprobeConfig = "options hid_apple fnmode=2";
  };

  fonts = {
    enableDefaultFonts = true;
    fontDir.enable = true;

    fonts = with pkgs; [
      nerdfonts
      noto-fonts-cjk-sans
      recursive
      twemoji-color-font
    ];

    fontconfig = {
      enable = true;
      allowBitmaps = true;
      defaultFonts = {
        emoji = ["Twitter Color Emoji"];
        monospace = ["Maple Mono NF"];
        sansSerif = ["Google Sans Text"];
      };
      hinting.style = "hintfull";
    };
  };

  networking = {
    hostName = "nix";
    useDHCP = false;

    networkmanager = {
      enable = true;
      wifi.macAddress = "random";
    };
  };

  services = {
    blueman.enable = true;
    flatpak.enable = true;
    mullvad-vpn.enable = true;

    gnome = {
      glib-networking.enable = true;
      gnome-keyring.enable = true;
    };

    pipewire = {
      enable = true;
      jack.enable = true;
      pulse.enable = true;

      alsa = {
        enable = true;
        support32Bit = true;
      };
    };

    tor = {
      enable = true;
      torsocks.enable = true;
    };

    xserver = {
      enable = true;
      videoDrivers = ["nvidia"];

      displayManager.startx.enable = true;
    };
  };

  programs = {
    fish.enable = true;
    ccache.enable = true;
    gamemode.enable = true;

    hyprland = {
      enable = true;
      package = pkgs.hyprland-nvidia;
    };
  };

  environment = {
    variables = {
      NIXOS_OZONE_WL = "1";
      GLFW_IM_MODULE = "true";
    };
    loginShellInit = ''
      dbus-update-activation-environment --systemd DISPLAY
      eval $(ssh-agent)
      eval $(gnome-keyring-daemon --start)
    '';
  };

  security = {
    pam.services.sddm.enableGnomeKeyring = true;
    polkit.enable = true;
    rtkit.enable = true;
  };

  powerManagement.cpuFreqGovernor = "performance";

  i18n = {
    extraLocaleSettings = {
      LC_TIME = "en_US.UTF-8";
    };
    inputMethod.enabled = "ibus";
    inputMethod.ibus.engines = with pkgs.ibus-engines; [uniemoji];
  };

  hardware = {
    bluetooth = {
      enable = true;
      package = pkgs.bluez;
    };

    nvidia = {
      modesetting.enable = true;
      open = true;
      powerManagement.enable = true;
    };

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
        nvidia-vaapi-driver
      ];
    };

    i2c.enable = true;
    pulseaudio.enable = false;
  };

  environment.extraInit = ''
    export LIBVA_DRIVER_NAME="nvidia"
    export GBM_BACKEND="nvidia-drm"
    export __GLX_VENDOR_LIBRARY_NAME="nvidia"
    export WLR_NO_HARDWARE_CURSORS=1
    export WLR_DRM_DEVICES="/dev/dri/card1:/dev/dri/card0"
    export GPG_TTY="$TTY"
    CLUTTER_BACKEND="wayland"
    XDG_SESSION_TYPE="wayland"
    QT_QPA_PLATFORM="wayland"
    QT_WAYLAND_DISABLE_WINDOWDECORATION=1
    WLR_BACKEND="vulkan"
    WLR_RENDERER="vulkan"
    GTK_THEME="Quixotic-pink"
  '';

  documentation.man.man-db.enable = false;

  virtualisation.docker.enable = true;

  nix.settings.trusted-users = ["root" "marshall"];

  xdg.portal.enable = true;

  system.stateVersion = "21.11";
}
