{
  stdenv,
  lib,
  fetchFromGitHub,
  wrapGAppsHook4,
  meson,
  ninja,
  pkg-config,
  glib,
  desktop-file-utils,
  gettext,
  librsvg,
  blueprint-compiler,
  python3Packages,
  appstream-glib,
  libadwaita,
  libportal,
  libportal-gtk4,
  gobject-introspection,
  python-material-color-utilities,
  sassc,
}:
# Not all parts of the application works with the current nixpkgs version of
# libadwaita.
python3Packages.buildPythonApplication rec {
  pname = "gradience";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "GradienceTeam";
    repo = "Gradience";
    rev = version;
    sha256 = "sha256-mTRkuKqeHrLiohp4l8izaZhixIRei0peKQZOiXxna2Y=";
  };

  format = "other";
  dontWrapGApps = true;

  nativeBuildInputs = [
    appstream-glib
    blueprint-compiler
    desktop-file-utils
    gettext
    glib
    gobject-introspection
    meson
    ninja
    pkg-config
    wrapGAppsHook4
    sassc
  ];

  buildInputs = [
    libadwaita
    libportal
    libportal-gtk4
    librsvg
  ];

  propagatedBuildInputs = with python3Packages;
    [
      anyascii
      aiohttp
      cssutils
      jinja2
      pygobject3
      svglib
      Yapsy
    ]
    ++ [
      python-material-color-utilities
    ];

  preFixup = ''
    makeWrapperArgs+=("''${gappsWrapperArgs[@]}")
  '';

  meta = with lib; {
    homepage = "https://github.com/GradienceTeam/Gradience";
    description = "Customize libadwaita and GTK3 apps (with adw-gtk3)";
    license = licenses.mit;
  };
}
