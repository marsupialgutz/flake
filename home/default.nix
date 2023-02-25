{
  inputs,
  pkgs,
  config,
  self,
  ...
}:
with pkgs; {
  home = {
    packages =
      [
        # SNOW BEGIN
        androidStudioPackages.canary
        audacity
        bacon
        binutils
        brightnessctl
        btop
        cachix
        carapace
        cargo-edit
        cargo-udeps
        cava
        cmake
        comma
        cozette
        curlie
        deno
        draconis
        edgedb
        file
        gcc
        gh
        gitoxide
        gjs
        gleam
        glib
        glrnvim
        gnome-extension-manager
        gnumake
        gopls
        gpick
        grex
        grim
        gsettings-desktop-schemas
        headsetcontrol
        httpie-desktop
        hyprpaper
        igrep
        inotify-tools
        insomnia
        ispell
        jamesdsp
        jetbrains-fleet
        jq
        keybase
        keychain
        lazygit
        libappindicator
        libffi
        libgda6
        libnotify
        lucky-commit
        lxappearance
        micro
        minecraft
        mold
        mullvad-vpn
        mysql
        neovide
        ngrok
        nix-output-monitor
        nix-prefetch-scripts
        nix-snow
        nodejs-19_x
        notion-app-enhanced
        nurl
        obsidian
        odin
        openal
        p7zip
        pavucontrol
        playerctl
        prismlauncher
        pscale
        pulseaudio
        python312
        qmk
        revolt
        riff
        rnix-lsp
        rofi-wayland
        rust-analyzer-nightly
        rustup
        scrot
        slurp
        starfetch
        starship
        statix
        stylua
        sumneko-lua-language-server
        swaynotificationcenter
        sx
        tdesktop
        tealdeer
        thunderbird-bin
        tre
        unrar
        unzip
        via
        waybar
        wf-recorder
        wget
        wl-clipboard
        wl-color-picker
        xclip
        yarn
        zls
        zscroll
        # SNOW END
      ]
      ++ (with inputs; [
        hyprland-contrib.packages.${pkgs.system}.grimblast
        nix-init.packages.${pkgs.system}.default
        xdg-hyprland.packages.${pkgs.system}.hyprland-share-picker
      ])
      ++ (with gnome; [
        dconf-editor
        eog
        file-roller
        gnome-session
        gnome-tweaks
        nautilus
        seahorse
        zenity
      ])
      ++ (with gnomeExtensions; [
        arcmenu
        blur-my-shell
        browser-tabs
        emoji-selector
        gnome-40-ui-improvements
        just-perfection
        no-overview
        openweather
        pano
        (pop-shell.overrideAttrs (old: {
          patches =
            old.patches
            ++ [
              "${self}/pkgs/pop-shell-remove-tiling-exceptions.patch"
            ];
        }))
        rounded-window-corners
        space-bar
        tray-icons-reloaded
      ])
      ++ (with nodePackages_latest; [
        eslint
        generator-code
        pnpm
        prettier
        typescript
        typescript-language-server
      ])
      ++ (with jetbrains; [
        idea-ultimate
        webstorm
        clion
      ]);
  };
}
