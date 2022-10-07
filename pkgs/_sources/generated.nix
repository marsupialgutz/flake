# This file was generated by nvfetcher, please do not modify it manually.
{
  fetchgit,
  fetchurl,
  fetchFromGitHub,
}: {
  astronaut-sddm-theme = {
    pname = "astronaut-sddm-theme";
    version = "ef7ff4199e0e78c37995938ad4ced402d34edf79";
    src = fetchFromGitHub {
      owner = "Keyitdev";
      repo = "sddm-astronaut-theme";
      rev = "ef7ff4199e0e78c37995938ad4ced402d34edf79";
      fetchSubmodules = false;
      sha256 = "sha256-I39W9U4j/MbyYp4BlB4sWuQ5GVf/z4bm4ohrSfIWcXI=";
    };
  };
  coc-tailwindcss3 = {
    pname = "coc-tailwindcss3";
    version = "fb91c3c3a22e537acfac73a82814689f95d6e82b";
    src = fetchFromGitHub {
      owner = "yaegassy";
      repo = "coc-tailwindcss3";
      rev = "fb91c3c3a22e537acfac73a82814689f95d6e82b";
      fetchSubmodules = false;
      sha256 = "sha256-dcALAfFDXBGVvK6fki9AD0lZKzvxo2LJ8A/TUyTF4pk=";
    };
  };
  copilot-vim = {
    pname = "copilot-vim";
    version = "af9da6457790b651871b687b8f47d130cde083fc";
    src = fetchFromGitHub {
      owner = "github";
      repo = "copilot.vim";
      rev = "af9da6457790b651871b687b8f47d130cde083fc";
      fetchSubmodules = false;
      sha256 = "sha256-K3Qs9L9kM2AJtwY7FqoBRIthTpqdg0YRD28WfJjodrY=";
    };
  };
  fleet = {
    pname = "fleet";
    version = "8dce51cab7a13caf1431a07368978bfc191b301c";
    src = fetchFromGitHub {
      owner = "dimensionhq";
      repo = "fleet";
      rev = "8dce51cab7a13caf1431a07368978bfc191b301c";
      fetchSubmodules = false;
      sha256 = "sha256-EZWY0KjJ68XvumyterziprbIe1wTU4NJbMuWW+gAt4c=";
    };
    cargoLock."Cargo.lock" = {
      lockFile = ./fleet-8dce51cab7a13caf1431a07368978bfc191b301c/Cargo.lock;
      outputHashes = {
      };
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
  openasar = {
    pname = "openasar";
    version = "c72f1a3fc064f61cc5c5a578d7350240e26a27af";
    src = fetchFromGitHub {
      owner = "GooseMod";
      repo = "OpenAsar";
      rev = "c72f1a3fc064f61cc5c5a578d7350240e26a27af";
      fetchSubmodules = false;
      sha256 = "sha256-6V9vLmj5ptMALFV57pMU2IGxNbFNyVcdvnrPgCEaUJ0=";
    };
  };
  spyglass = {
    pname = "spyglass";
    version = "d41769ef45fa4e61776712a111c23e8893018d7d";
    src = fetchFromGitHub {
      owner = "a5huynh";
      repo = "spyglass";
      rev = "d41769ef45fa4e61776712a111c23e8893018d7d";
      fetchSubmodules = false;
      sha256 = "sha256-9fMY+Y916XABPm2dzH18tkYFnWjVOrCWyAKpBJj8Jzc=";
    };
    cargoLock."Cargo.lock" = {
      lockFile = ./spyglass-d41769ef45fa4e61776712a111c23e8893018d7d/Cargo.lock;
      outputHashes = {
      };
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
