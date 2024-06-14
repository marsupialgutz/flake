{pkgs, ...}: {
  programs.fish = let
    mkFishPlugins = names:
      map (name: {
        inherit name;
        inherit (pkgs.fishPlugins.${name}) src;
      })
      names;
  in {
    enable = true;

    plugins =
      (
        with pkgs; [
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
            name = "bang-bang";
            src = fetchFromGitHub {
              owner = "oh-my-fish";
              repo = "plugin-bang-bang";
              rev = "ec991b80ba7d4dda7a962167b036efc5c2d79419";
              hash = "sha256-oPPCtFN2DPuM//c48SXb4TrFRjJtccg0YPXcAo0Lxq0=";
            };
          }
        ]
      )
      ++ (mkFishPlugins ["autopair" "bass" "colored-man-pages" "done" "fifc" "git-abbr" "forgit" "grc"]);

    shellAliases = with pkgs; {
      cat = "${bat}/bin/bat";
      df = "${duf}/bin/duf";
      rm = "${rm-improved}/bin/rip";
      cp = "${xcp}/bin/xcp";
    };

    interactiveShellInit = ''
      function fish_greeting
        macchina
      end
    '';
  };
}
