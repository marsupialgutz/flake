# This file was generated by nvfetcher, please do not modify it manually.
{
  fetchgit,
  fetchurl,
  fetchFromGitHub,
}: {
  copilot-vim = {
    pname = "copilot-vim";
    version = "8ba151a20bc1d7a5c72e592e51bfc925d5bbb837";
    src = fetchFromGitHub {
      owner = "github";
      repo = "copilot.vim";
      rev = "8ba151a20bc1d7a5c72e592e51bfc925d5bbb837";
      fetchSubmodules = false;
      sha256 = "sha256-GmwR+S5sQnVUbVShP53jNpSKMZaoeh9Rf37v89wAJ3M=";
    };
  };
  nvim-cokeline = {
    pname = "nvim-cokeline";
    version = "501f93ec84af0d505d95d3827cad470b9c5e86dc";
    src = fetchFromGitHub {
      owner = "noib3";
      repo = "nvim-cokeline";
      rev = "501f93ec84af0d505d95d3827cad470b9c5e86dc";
      fetchSubmodules = false;
      sha256 = "sha256-BQP4jOm55YeDfabsSdfEiRk2O7t7KARklSbyfBK5Zu0=";
    };
  };
  nvim-staline = {
    pname = "nvim-staline";
    version = "c2ac9411815cf7fb135d798174ff5782e1b64075";
    src = fetchFromGitHub {
      owner = "tamton-aquib";
      repo = "staline.nvim";
      rev = "c2ac9411815cf7fb135d798174ff5782e1b64075";
      fetchSubmodules = false;
      sha256 = "sha256-y7vuzCuwYN8+eSTP2bffh1ATjlbOyObpOobgM51Zl5c=";
    };
  };
  openasar = {
    pname = "openasar";
    version = "7a04cb57dff43f328de78addc234e9d21ff079a8";
    src = fetchFromGitHub {
      owner = "GooseMod";
      repo = "OpenAsar";
      rev = "7a04cb57dff43f328de78addc234e9d21ff079a8";
      fetchSubmodules = false;
      sha256 = "sha256-6zYXv+iAfDEFHQ4FwNVEA4+zWiDyeLvkm17f4LuaCJg=";
    };
  };
  zscroll = {
    pname = "zscroll";
    version = "788be9650b647f61f8f899054ad1213eee42e8a4";
    src = fetchFromGitHub {
      owner = "noctuid";
      repo = "zscroll";
      rev = "788be9650b647f61f8f899054ad1213eee42e8a4";
      fetchSubmodules = false;
      sha256 = "sha256-gEluWzCbztO4N1wdFab+2xH7l9w5HqZVzp2LrdjHSRM=";
    };
  };
}
