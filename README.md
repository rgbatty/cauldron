<div align="center">
    <h1>
        <a name="top" title="dotfiles"><img src="assets/cauldron.png?raw=true" style=" width:120px ; height:120px " /></a><br/>Cauldron: A Colony of Bats and other Witchcraft<br/> <sup><sub>powered by  <a href="https://nixos.org">Nix</a> ❄</sub></sup>
        <sup><sub>Themed with  <a href="https://draculatheme.com">Dracula</a> 🦇</sub></sup>
    </h1>

<!-- badges -->

[Goals](#goals-) • [Installation](#installation-) • [Toolset](#supported-toolset-) • [Resources](#resources-)
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

## TODO

### P0: Missing Configuration
- Mac: `.macos` system settings, `Terminal.app` settings, Homebrew update
- Assets: Wallpapers ([Dracula Wallpapers](https://draculatheme.com/wallpaper))

### P1: Polish
- VS Code
- Completions: Bash, Zsh, Fish

### P2: Theming: General
- MacOS-Specific: [Alfred](https://draculatheme.com/alfred), [iTerm](https://draculatheme.com/iterm), [Terminal.app](https://draculatheme.com/terminal), [XCode](https://draculatheme.com/xcode)

## Goals ⚽

### Core Tenets
- Cross-platform parity
- Declaritive configuration for all users and systems
- One-liner installation on fresh systems
- Theming support wherever possible

### For the Future
- New shell: [WezTerm](https://wezfurlong.org/wezterm/), [(Dracula Theme)](https://draculatheme.com/wezterm)
- Spotify: [Spicetify](https://github.com/spicetify) or a CLI tool (eg. [ncspot](https://github.com/hrkfdn/ncspot)) (theming, less overhead)
- ASDF <-> DirEnv: [Repo](https://github.com/asdf-community/asdf-direnv)
- Vim: Learning (Vim Adventures, Vim in VS Code), configuration
- Doom Emacs: [Doom Emacs](https://github.com/doomemacs/doomemacs)
- Tmux: Learn, decide on tooling ([Tmuxinator](https://github.com/tmuxinator/tmuxinator))
- Yabai
- Add Chocolatey
- Starship Customization: `.config/starship.toml`

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

## Installation 🔮

### Darwin

- temporarily change to Bash if needed:
```
exec bash
```
- Install Nix:
```
sh <(curl -L https://nixos.org/nix/install --darwin-use-unencrypted-nix-store-volume --daemon
```
- Build and install Nix-Darwin:
```
nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
./result/bin/darwin-installer
```
- Enable Flakes:
```
mkdir -p ~/.config/nix
echo 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.conf
```
- Clone and cd to project:
```
https://github.com/rgbatty/cauldron && cd cauldron
```
- Build and apply using build (for flake support), replacing `<host>` with chosen:
```
nix build cauldron/\#darwinConfigurations.<host>.system
./result/sw/bin/darwin-rebuild switch --flake .#darwin-<host>
```

### Build Outputs

User definitions can be found in `./home/users/default.nix`, with system-definitions in their respective `./<system>/default.nix`. Build outputs are listed under the `checks` section for `nix flake show`.

**Darwin**:
- Command: `darwin-rebuild switch --flake .#<user>@<host>`
- Working example: `darwin-rebuild switch --flake github:rgbatty/cauldron .#rgbatty@luna`

**NixOS**
- Command: `nixos rebuild switch --flake .#<user>@<host>`
- Working example: `darwin-rebuild switch --flake github:rgbatty/cauldron .#rgbatty@koumori`

**Home Manager**
- Command: `home-manager switch --flake .#<user>@<host>`
- Working example: `darwin-rebuild switch --flake github:rgbatty/cauldron .#rgbatty@koumori`

### Theming
Any themed tools have been denoted with a 🦇, linking to the theme repository it uses. Some items require manual theming steps. Those have been denoted in the Supported Toolset section with a 🔨 next to their theme. Theming work has been duplicated and saved within these dotfiles to limit depedencies, and full credits are to their respective authors. Massive thanks are due to the Dracula theming community as a whole for their awesome support of a beautiful theme.


### The Nix Kool-Aid

> Nix allows for easy to manage, collaborative, reproducible deployments. This means that once something is setup and configured once, it works forever. If someone else shares their configuration, anyone can make use of it.

### Project Structure

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

## Supported Toolset 🛠️

### 💻 Terminals

<!-- -   [Terminal.app](https://iterm2.com/), [Theme](https://draculatheme.com/terminal) -->
<!-- -   [iTerm2](https://iterm2.com/), [Theme](https://draculatheme.com/iterm) -->
-   [🦇](https://draculatheme.com/windows-terminal)[Windows Terminal](https://www.microsoft.com/en-us/p/windows-terminal-preview/9n0dx20hk701): [Settings](./dot_config/windows_terminal/settings.json)

### 🐚 Shells
- [Bash](https://www.gnu.org/software/bash/)
    <!-- - [Bash-it](): [Settings] -->
- [🦇](https://draculatheme.com/fish)[Fish](https://fishshell.com)
    - Framework: [Fisher](https://github.com/jorgebucaran/fisher)
- [Z shell](http://zsh.sourceforge.net/)
    - Framework: [Zimfw](https://zimfw.sh)
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
