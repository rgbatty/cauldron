<div align="center">

<a name="top" title="dotfiles"><img src="assets/cauldron.png?raw=true" style=" width:120px ; height:120px " /></a>
# Cauldron: A Colony of Bats and other Witchcraft

<!-- Navigation -->
[Installation](#installation-) • [Nix](#the-nix-kool-aid) • [Usage](#usage) • [Toolset](#supported-toolset) • [Resources](#resources)

<!-- badges -->
![License](https://img.shields.io/github/license/rgbatty/cauldron?style=flat-square)
![Latest commit](https://img.shields.io/github/last-commit/rgbatty/cauldron/master?style=flat-square)
![Build status: master](https://img.shields.io/github/workflow/status/rgbatty/cauldron/CI/master?style=flat-square)
![Supports Emacs 27.1 - 28.1](https://img.shields.io/badge/Supports-Emacs_27.1--28.1-blueviolet.svg?style=flat-square&logo=GNU%20Emacs&logoColor=white)

<!-- Screenshot -->
![Cauldron Screenshot](https://raw.githubusercontent.com/doomemacs/doomemacs/screenshots/main.png)
</div>

REMOVE THIS PLACEHOLDER IMAGE

---

<!-- Description -->

Cauldron is a collection of host and user declarations for my personal computing ecosystem, all managed using [Nix](https://nixos.org).

...It's also the collective name for a colony of bats - my favorite animal and namesake!

Given it's personal nature, these files are in a constant state of flux as my needs grow and change. That said, I welcome any and all to find inspiration. It may be a little battered and rusted, but your sure to find the tools needed for any and all brews, witchcraft, and vampiric efforts - hopefully without the need for any sacrifices.

---

## The Nix Kool-Aid

> Nix allows for easy to manage, collaborative, reproducible deployments. This means that once something is setup and configured once, it works forever. If someone else shares their configuration, anyone can make use of it.

This repo, having previously tried other dotfile management tools, has settled on Nix - predominantly out of personal interest. Nix has been a fascinating rabbit hole, but be forewarned that it is not for beginners. Development is fast, documentation can be poor, but the reward of idempotent, declarative configuration is equally exciting.

For those wondering, "how do you configure X?" take a look at `./modules`. The majority of these are self-explanatory, though the syntax may not be. Raw dotfiles are kept within their associated user profile or the module itself.

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

## Installation 🔮

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/rgbatty/cauldron/main/bin/bootstrap.sh)"
```

The one-liner above will:

- Install xcode and brew for darwin systems
- Install make
- Install Nix
- Enable Nix Flakes
- Install Nix-Darwin for darwin systems
- Verify SSH credentials are present
- Pull down this repo to `~/.dotfiles`
- Create the `batts` alias for Just detailed in [Usage](#usage)

It is intended to be **100% idempototent.** Due to the nature of Nix and how it modifies your shell, it typically requires an additional run after shell reload for the Nix install.

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

## Usage

This project utilizes [Just](https://github.com/casey/just), an alternative to `make`, to manage its build outputs. This is available by default within the project directory, through `direnv`. Traditional outputs (eg. `homeManagerConfigurations`, `darwinConfigurations`, `nixosConfigurations`) remain for troubleshooting and usage outside of `just`.

Hostnames should be lowercase to ensure `just` compatability.

Common commands (listable with `just -l`) are:

- `just switch-home`: Build and apply home-manager output `<user@host>`.
- `just switch-darwin`: Build and apply nix-darwin output `darwin-<host>`.
- `just switch-nixos`: Build and apply NixOS output `nixos-<host>`.

### Configuration Profiles

Outputs should be named `<nixos/darwin>-<host>` for `nixosConfigurations` and `darwinConfigurations`, while `homeManagerConfigurations` are expected to be named `<user>@<host>`. Examples of each can be found in their respective `./flake-parts` file.

Meanwhile, configuration files are available within `./profiles`, sorted by `./users` and `./hosts`. Option declarations can be found within `./modules`, nested under the matching path.

By default, the flake attempts to provide outputs by granularity. The highest matching level will be used, following a pattern of:

```
System < Host < User
```

Given just a `system` (eg. `aarch64-darwin`), the flake will apply configuration for `aarch64-darwin`, using defaults for `user` and `host` details, applying them to the currently logged in user.

Simply forking the repo, adding your `profiles`, and re-running the desired `just` command will apply your new configurations wherever they are relevant.

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

## Supported Toolset

Given the ephemeral nature of dotfiles, the given active toolset is likely to change on a whim. I highly encourage you take a look at `./modules`, as its quite well sorted and intended to be a running collection of all configurations I might need, with `./profiles` enabling and disabling as necessary.

On a high level:

------

|                |                                                          |
|----------------|----------------------------------------------------------|
| **Shell:**     | [fish](https://github.com/fish-shell/fish-shell) + a variety of utilities ([bat](https://github.com/sharkdp/bat), [exa](https://github.com/ogham/exa), [fzf](https://github.com/junegunn/fzf), [zoxide](https://github.com/ajeetdsouza/zoxide)) |
| **DM:**        | TBD |
| **WM:**        | (darwin) [yabai](https://github.com/koekeishiya/yabai) + [skhd](https://github.com/koekeishiya/skhd) + [sketchybar](https://github.com/FelixKratz/SketchyBar) (linux) TBD |
| **Editor:**    | [VS Code](https://github.com/microsoft/vscode) (future): [Doom Emacs](https://github.com/doomemacs/doomemacs) |
| **Terminal:**  | (darwin): [iTerm2](https://github.com/gnachman/iTerm2) (windows): [Windows Terminal](https://github.com/microsoft/terminal) (future): [wezterm](https://github.com/wez/wezterm) |
| **Launcher:**  | (darwin) [Alfred](https://alfredapp.com) (linux) TBD (windows) [Flow Laucher](https://github.com/Flow-Launcher/Flow.Launcher) |
| **Keyboard:**   | [Corne v3 (Choc)](https://github.com/foostan/crkbd), Choc Purpz switches, [Miryoku](https://github.com/manna-harbour/miryoku) layout |
| **Browser:**   | [Vivaldi](https://vivaldi.com) |
| **Theme:** | [Dracula](https://github.com/dracula/dracula-theme) |

-----

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

## Resources

This repo has been heavily inspired by the excellent work of many other engineers, who have graciously shared their dotfile repos with the rest of us to tweak, modify, and steal to our hearts' content. Hopefully my addition will provide help and guidance for others as those engineers have for me. Please take a moment to view these projects, as Cauldron would not be possible otherwise.

### Inspirations
- :octocat: [G6ai's Dotfiles](https://github.com/g6ai/dotfiles)
- :octocat: [Mathias Byren's Dotfiles](https://github.com/mathiasbynens/dotfiles)
- :octocat: [Narze's Dotfiles](https://github.com/narze/dotfiles)
- :octocat: [Paul Irish's Dotfiles](https://github.com/paulirish/dotfiles)
- :octocat: [René-Marc Simard's Dotfiles](https://github.com/renemarc/dotfiles)

### Learning References
- [dotfiles.github.io](https://dotfiles.github.io/)

### Projects
- [Shell Awesome List](https://project-awesome.org/alebcay/awesome-shell)
- [Fish Awesome List](https://github.com/jorgebucaran/awsm.fish)

<p align="center"><strong><sub>🦇 Assembled with <b title="love">💜</b> in Denver, CO. 🦇</sub></strong></p>

<!-- Badge URLS -->
