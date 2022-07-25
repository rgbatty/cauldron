<div align="center">
    <h1>
        <a name="top" title="dotfiles"><img src="assets/cauldron.png?raw=true" style=" width:120px ; height:120px " /></a><br/>Cauldron: A Colony of Bats and other Witchcraft<br/> <sup><sub>powered by  <a href="https://nixos.org">Nix</a> ❄</sub></sup>
        <sup><sub>Themed with  <a href="https://draculatheme.com">Dracula</a> 🦇</sub></sup>
    </h1>

<!-- badges -->

[Installation](#installation-) • [Nix](#the-nix-kool-aid) • [Usage](#usage) • [Toolset](#supported-toolset) • [Resources](#resources)
</div>

<!-- Description -->

Cauldron is a collection of host and user declarations for my personal computing ecosystem, all managed using [Nix](https://nixos.org).

...It's also the collective name for a colony of bats - my favorite animal and namesake!

Given it's personal nature, these files are in a constant state of flux as my needs grow and change. That said, I welcome any and all to find inspiration. It may be a little battered and rusted, but your sure to find the tools needed for any and all brews, witchcraft, and vampiric efforts - hopefully without the need for any sacrifices.

<!-- Star/Fork -->

<div align="center">
    <p><strong>Be sure to <a href="#" title="star">⭐️</a> or <a href="#" title="fork">🔱</a> this repo if you find it useful! 😃</strong></p>
</div>

## The Nix Kool-Aid

> Nix allows for easy to manage, collaborative, reproducible deployments. This means that once something is setup and configured once, it works forever. If someone else shares their configuration, anyone can make use of it.

This repo, having previously tried other dotfile management tools, has settled on Nix - predominantly out of personal interest. Nix has been a fascinating rabbit hole, but be forewarned that it is not for beginners. Development is fast, documentation can be poor, but the reward of idempotent, declarative configuration is equally exciting.

For those wondering, "how do you configure X?" take a look at `./modules`. The majority of these are self-explanatory, though the syntax may not be. Raw dotfiles are kept within their associated user profile or the module itself.

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

## Installation 🔮

Listed below are installation steps for each supported platform. These are subject to change and may be out of date, but are consolidated for ease. I highly recommend users view the individual documentation for each.

In summary, expect to install Nix, enable flakes, pull the repo, and then build and apply the output you're interested in.

<details>
<summary>

### Darwin

</summary>

Install Nix:
```
sh <(curl -L https://nixos.org/nix/install --darwin-use-unencrypted-nix-store-volume --daemon
```

Enable Nix Flakes support:
```
mkdir -p ~/.config/nix
echo 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.conf
```

Install Nix-Darwin:
```
nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
./result/bin/darwin-installer
```

After cloning and moving to the project directory, build and apply using build package (for flake support), replacing `<host>` with chosen host (listed in `./flake-parts/darwin.nix`):
```
nix build .#darwinConfigurations.<host>.system
./result/sw/bin/darwin-rebuild switch --flake .#darwinConfigurations.<host>
```
</details>

<details>
<summary>

### NixOS

</summary>

Enable Nix Flakes support:
```
mkdir -p ~/.config/nix
echo 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.conf
```

After cloning and moving to the project directory, build and apply your chosen home-manager configuration, replacing `<host>` with chosen host (listed in `./flake-parts/nixos.nix`):
```
sudo nixos-rebuild switch --flake .#nixosConfigurations.<host>
```
</details>

<details>
<summary>

### Linux

</summary>

Install Nix:
```
sh <(curl -L https://nixos.org/nix/install --darwin-use-unencrypted-nix-store-volume --daemon
```

Enable Nix Flakes support:
```
mkdir -p ~/.config/nix
echo 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.conf
```

Install Home Manager:
```
# Add the Nix Channel
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

# Update your path for Non-NixOS hosts
export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}

# Install Home Manager
nix-shell '<home-manager>' -A install
```

After cloning and moving to the project directory, build and apply your chosen home-manager configuration, replacing `<user@host>` with the chosen user and host (listed in `./flake-parts/darwin.nix`):
```
home-manager switch --flake .#homeManagerConfigurations.<user@host>
```
</details>

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
