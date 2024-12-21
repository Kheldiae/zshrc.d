{ pkgs, lib, stdenv, fetchgit, emptyDirectory, ... }:

let
  locks = builtins.fromJSON (builtins.readFile ./bootstrap.lock);
  repos = builtins.mapAttrs
    (k: v: fetchgit { inherit (v) url rev sha256 leaveDotGit; }) locks;
  owner = l: builtins.head (lib.splitString "/" l);
in stdenv.mkDerivation {
  name = "zplug-bootstrap";
  src = emptyDirectory;
  installPhase = builtins.foldl' (l: r: ''
    ${l}
              mkdir -p $out/${owner r}
              cp -r ${repos.${r}} $out/${r}
  '') "mkdir -p $out" (builtins.attrNames repos);
}
