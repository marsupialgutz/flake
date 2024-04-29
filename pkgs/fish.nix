{pkgs, ...}: {
  programs.fish = {
    enable = true;

    plugins = with pkgs; [
      {
        name = "replay.fish";
        src = fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "replay.fish";
          rev = "bd8e5b89ec78313538e747f0292fcaf631e87bd2";
          hash = "sha256-bM6+oAd/HXaVgpJMut8bwqO54Le33hwO9qet9paK1kY=";
        };
      }
      {
        name = "license";
        src = fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-license";
          rev = "0155b16f102957ec0c734a90979245dc1073f979";
          hash = "sha256-Bi9Q5rekZoyXYbRV+U4SmwCdqCl0pFupzm5si7SxFns=";
        };
      }
      {
        name = "wttr";
        src = fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-wttr";
          rev = "7500e382e6b29a463edc57598217ce0cfaf8c90c";
          hash = "sha256-k3FrRPxKCiObO6HgtDx8ORbcLmfSYQsQeq5SAoNfZbE=";
        };
      }
      {
        name = "gityaw";
        src = fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-gityaw";
          rev = "59196560e0f4520db63fb8cab645510377bb8b13";
          hash = "sha256-STXNxSsjSopB+lbB4hEYdhJifRfsImRwbZ1SxwEhkuM=";
        };
      }
      {
        name = "brew";
        src = fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-brew";
          rev = "328fc82e1c8e6fd5edc539de07e954230a9f2cef";
          hash = "sha256-ny82EAz0K4XYASEP/K8oxyhyumrITwC5lLRd+HScmNQ=";
        };
      }
      {
        name = "bang-bang";
        src = fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-bang-bang";
          rev = "ec991b80ba7d4dda7a962167b036efc5c2d79419";
          hash = "sha256-oPPCtFN2DPuM//c48SXb4TrFRjJtccg0YPXcAo0Lxq0=";
        };
      }
      {
        name = "grc";
        src = fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-grc";
          rev = "61de7a8a0d7bda3234f8703d6e07c671992eb079";
          hash = "sha256-NQa12L0zlEz2EJjMDhWUhw5cz/zcFokjuCK5ZofTn+Q=";
        };
      }
      {
        name = "autopair";
        src = fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "autopair.fish";
          rev = "4d1752ff5b39819ab58d7337c69220342e9de0e2";
          hash = "sha256-qt3t1iKRRNuiLWiVoiAYOu+9E7jsyECyIqZJ/oRIT1A=";
        };
      }
      {
        name = "done";
        src = fetchFromGitHub {
          owner = "franciscolourenco";
          repo = "done";
          rev = "d47f4d6551cccb0e46edfb14213ca0097ee22f9a";
          hash = "sha256-VSCYsGjNPSFIZSdLrkc7TU7qyPVm8UupOoav5UqXPMk=";
        };
      }
    ];

    shellAliases = {
      gs = "git status";
      gd = "git diff";
      gc = "git commit";
      gca = "git commit --amend";
      gco = "git checkout";
      gcb = "git checkout -b";
      ga = "git add";
      gap = "git add --patch";
      gaa = "git add --all";
      gp = "git push";
      gpl = "git pull";
      gcap = "git add && git commit && git push";
      cat = "bat";
      df = "duf";
      rm = "rip";
      cp = "xcp";
    };

    loginShellInit = ''
      ssh-add --apple-load-keychain 2>/dev/null &
    '';

    interactiveShellInit = ''
      set fish_greeting
      fish_add_path /run/current-system/sw/bin
      fish_add_path /Users/marshall/.bun/bin
      set -gx NIXPKGS_ALLOW_UNFREE 1
      set -gx LIBRARY_PATH /opt/homebrew/lib:/opt/homebrew/opt/libiconv/lib

      if test "$TERM_PROGRAM" != "vscode"
        macchina
      end

      printf '\eP$f{"hook": "SourcedRcFileForWarp", "value": { "shell": "fish"}}\x9c'
    '';
  };
}
