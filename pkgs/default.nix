final: prev: let
  sources = prev.callPackage ./_sources/generated.nix {};
in {
  spicetify-cli = with prev;
    spicetify-cli.overrideAttrs (_: {
      inherit (sources.spicetify-cli) pname version src;
      postInstall = ''
        cp -r ./jsHelper ./Themes ./Extensions ./CustomApps ./globals.d.ts ./css-map.json $out/bin
      '';
    });
  spicetify-themes = sources.spicetify-themes.src;
  catppuccin-spicetify = sources.catppuccin-spicetify.src;
  spotify-spicetified = final.callPackage ./spotify-spicetified {};

  picom = prev.picom.overrideAttrs (o: {
    inherit (sources.picom) src pname version;
  });
  awesome =
    (prev.awesome.overrideAttrs (old: {
      inherit (sources.awesome) src pname version;
      patches = [];
      GI_TYPELIB_PATH =
        "${prev.playerctl}/lib/girepository-1.0:"
        + "${prev.upower}/lib/girepository-1.0:"
        + old.GI_TYPELIB_PATH;
    }))
    .override {
      stdenv = prev.clangStdenv;
      gtk3Support = true;
    };
  mySddmTheme = prev.plasma5Packages.mkDerivation {
    inherit (sources.aerial-sddm-theme) src pname version;
    propagatedUserEnvPkgs = with prev.plasma5Packages; [qtgraphicaleffects];
    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -r ./. $out/share/sddm/themes/aerial-sddm-theme
    '';
  };
}
