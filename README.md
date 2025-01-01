# My personal zsh (and other) config

## Try it out!

That's right! You can take my zsh configuration for a spin _right now_, without clobbering your existing configuration!

Just clone this repository and run the `zsh` script at its root!

## Install it

This repository contains an ordered set of loadable zsh scripts. In order to install it, you need to add the lines contained in `zshrc.template` to your own `.zshrc`, making sure to have `ZSH_CONFIG_PATH` pointing to this repository.

This configuration works best with Nix, kitty and [my Neovim config](https://github.com/kheldae/nvim-config), but those are not hard requirements. For Nix enjoyers, you can also import the `zsh` package in this Nix flake into your NixOS configuration.

## Tweaks

If you want to tweak it but keep the ability to use updates through `git pull`, I strongly advise using these paths instead of editing the current files to add your own tweaks :

- `21-my-functions.zsh`
- `26-my-aliases.zsh`
