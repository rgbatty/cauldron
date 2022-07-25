<div align="center">
    <h1>
        <a name="top" title="dotfiles"><img src="assets/cauldron.png?raw=true" style=" width:120px ; height:120px " /></a><br/>Cauldron: A Colony of Bats and other Witchcraft<br/> <sup><sub>powered by  <a href="https://nixos.org">Nix</a> ❄</sub></sup>
        <sup><sub>Themed with  <a href="https://draculatheme.com">Dracula</a> 🦇</sub></sup>
    </h1>

<!-- badges -->

[Installation](#installation-) • [Usage](#usage) • [Toolset](#supported-toolset-) • [Resources](#resources-)
</div>

<!-- Description -->

Cauldron is a collection of host and user declarations for my personal computing ecosystem, all managed using [Nix]().

...It's also the collective name for a colony of bats - my favorite animal and namesake!

This repo has been heavily inspired by the excellent work of many other engineers, who have graciously shared their dotfile repos with the rest of us to tweak, modify, and steal to our hearts' content. Hopefully my addition will provide help and guidance for others as those engineers have for me. Please take a moment to view the [Resources](#resources-) at the end of this README to explore just a few the inspirations for this project.

Given it's personal nature, these files are in a constant state of flux as my needs grow and change. That said, I welcome any and all to find inspiration. It may be a little battered and rusted, but your sure to find the tools needed for any and all brews, witchcraft, and vampiric efforts - hopefully without the need for any sacrifices.

<!-- Star/Fork -->

<div align="center">
    <p><strong>Be sure to <a href="#" title="star">⭐️</a> or <a href="#" title="fork">🔱</a> this repo if you find it useful! 😃</strong></p>
</div>

## Installation 🔮

Listed below are installation steps for each supported platform. These are subject to change and may be out of date, but are consolidated for ease. I highly recommend users view the individual documentation for each.

In summary, expect to install Nix, enable flakes, pull the repo, and then build and apply the output you're interested in.

<details>
<summary> ### Darwin </summary>

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
<summary> ### NixOS </summary>

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
<summary> ### Linux </summary>

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

## Configuration

This project utilizes [Just](https://github.com/casey/just), an alternative to `make`, to manage its build outputs.

Outputs should be named `<system>-<host>` for `nixosConfigurations` and `darwinConfigurations`, while `homeManagerConfigurations` are expected to be named `<user>@<host>`. Examples of each can be found in their respective `./flake-parts` file.

By default, the flake attempts to provide outputs by granularity. The highest matching level will be used, following a pattern of:

```
System < Host < User
```

Given just a `system` (eg. `aarch64-darwin`), the flake will apply configuration for `aarch64-darwin`, using defaults for `user` and `host` details, applying them to the currently logged in user.

Simply forking the repo, adding your `profiles`, and re-running the desired `just` command will apply your new configurations wherever they are relevant.
### The Nix Kool-Aid

> Nix allows for easy to manage, collaborative, reproducible deployments. This means that once something is setup and configured once, it works forever. If someone else shares their configuration, anyone can make use of it.

### Project Structure

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

## Supported Toolset 🛠️

### 💻 Terminals

<!-- -   [iTerm2](https://iterm2.com/), [Theme](https://draculatheme.com/iterm) -->
-   [🦇](https://draculatheme.com/windows-terminal)[Windows Terminal](https://www.microsoft.com/en-us/p/windows-terminal-preview/9n0dx20hk701): [Settings](./dot_config/windows_terminal/settings.json)

### 🐚 Shells
- [Bash](https://www.gnu.org/software/bash/)
    <!-- - [Bash-it](): [Settings] -->
- [🦇](https://draculatheme.com/fish)[Fish](https://fishshell.com)
    - Framework: [Fisher](https://github.com/jorgebucaran/fisher)
- [Z shell](http://zsh.sourceforge.net/)
    - [🦇](https://draculatheme.com/zsh-syntax-highlighting)[Zsh Syntax Highlighting]()
<!-- - [Powershell](): [Settings](), [🦇](https://draculatheme.com/powershell) -->

### 📦 Package Managers

Most packages are managed through [NixPkgs](). In cases that the package is unavailable or cannot be managed on a specific host, the package manager and its manifest is listed below.

- MacOS: [Homebrew](https://brew.sh/): [Packages]()
- Windows: [Chocolatey/Scoop](): [Packages]()

### 💾 Universal Packages
- [OpenSSH](https://www.openssh.com/) secure networking utilities
- [Git :octocat:](https://git-scm.com/) version-control system
- [DirEnv](https://github.com/direnv/direnv): Per-directory environment variables
<!-- - [ASDF Version Manager](http://asdf-vm.com/): [Tool Versions](./dot_tool-versions) -->
- [cURL](https://curl.haxx.se/) data transfer tool
<!-- - [GNU Wget](https://www.gnu.org/software/wget/) HTTP/FTP file downloader: [Settings](./dot_wgetrc) -->
- [🦇](https://draculatheme.com/starship)[Starship 🚀](https://starship.rs) cross-shell prompt
<!-- - [tmux](https://github.com/tmux/tmux/wiki) terminal multiplexer: [Settings](./dot_tmux.conf.local), [Theme](https://draculatheme.com/tmux) -->
- [Zoxide](https://github.com/ajeetdsouza/zoxide): Smarter `cd`
- [fzf](https://github.com/junegunn/fzf): Fuzzy finder
- [Forgit](https://github.com/wfxr/forgit): CLI git app
- [Navi](https://github.com/denisidoro/navi): CLI one-liners/cheat sheet

### 📝 Editors

- [🦇](https://draculatheme.com/visual-studio-code)[VS Code](): [Settings](), [Extensions](./home/private_dot_config/Code/extensions.md)
<!-- - [Vim](https://www.vim.org/): [Settings](./dot_vimrc), [Extensions](), [Theme](https://draculatheme.com/vim)
- [Doom Emacs](https://github.com/doomemacs/doomemacs): [Settings](), [Extensions](), [Theme](https://draculatheme.com/doom-emacs) -->
<!-- - [GNU Nano 4.x+](https://www.nano-editor.org/) -->


### Browsers & Extensions
- [🦇](https://draculatheme.com/chrome)🔨[Chrome]()
- [🦇](https://draculatheme.com/firefox)🔨[Firefox]()
- [🦇](https://draculatheme.com/vivaldi)🔨[Vivaldi]()
- [🦇](https://draculatheme.com/vimium)🔨[Vimium]()

### Universal Apps
- [🦇](https://draculatheme.com/slack)🔨[Slack]()
- [🦇](https://draculatheme.com/eclipse)🔨[Eclipse]()
- [🦇](https://draculatheme.com/insomnia)🔨[Insomnia]()
- [🦇](https://draculatheme.com/steam)🔨[Steam]()
- [🦇](https://draculatheme.com/figma)🔨[Figma]()
- [🦇](https://draculatheme.com/blender)🔨[Blender]()
- [🦇](https://draculatheme.com/obsidian)🔨[Obsidian]()
- [🦇](https://draculatheme.com/tabletop-simulator)🔨[Tabletop Simulator]()
- [🦇](https://draculatheme.com/em-client)🔨[em Client]()

### 💾 Web Tools
- [🦇](https://draculatheme.com/github)🔨[GitHub]():
- [🦇](https://draculatheme.com/stackoverflow)🔨[StackOverflow]():
- [🦇](https://draculatheme.com/gitlab)🔨[GitLab]():
- [🦇](https://draculatheme.com/github-pages)🔨[GitHub Pages]():
- [🦇](https://draculatheme.com/monkeytype)🔨[MonkeyType]():

### MacOS
- [🦇](https://draculatheme.com/alfred)[Alfred](): [Settings]()

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

## Resources 💡

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
