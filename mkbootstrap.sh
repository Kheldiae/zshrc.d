#!/usr/bin/env -S ./nix shell nixpkgs#nix-prefetch-git nixpkgs#parallel --command bash
# Generate Nix bootstrap package for Zplug
# (c) Karim Vergnes <me@thesola.io>

set -e -o pipefail

: ${_ZPLUG_OHMYZSH:=robbyrussell/oh-my-zsh}

first=1

_each_repo() {
    awk 'match($0, /^zplug +"(.*)"/, a) { print a[1] }' < 01-plugins.zsh \
        | grep -Ev '(lib|plugins)/'
    echo $_ZPLUG_OHMYZSH
}

_prefetch_git() {
    owner=$(cut -d/ -f1 <<< $1)
    repo=$(cut -d/ -f2 <<< $1)
    nix-prefetch-git --url https://github.com/$1 --quiet > /tmp/git-$owner-$repo
}

{
  echo -n "{"
  export -f _prefetch_git
  _each_repo | parallel --bar _prefetch_git >&2
  _each_repo \
  | while IFS= read -r line
    do
      owner=$(cut -d/ -f1 <<< $line)
      repo=$(cut -d/ -f2 <<< $line)
      ((first)) || echo -n ","
      echo -n "\"$line\":"
      cat /tmp/git-$owner-$repo
      rm /tmp/git-$owner-$repo
      first=0
    done
  echo -n "}"
} > bootstrap.lock

