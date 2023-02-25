#! /bin/sh
#
# Bootstraps dependencies for Cauldron hosts
#

# Environment variables
SSH_KEY_EMAIL_ADDRESS="rgbatty@outlook.com"
SSH_KEY_LOCATION="$HOME"/.ssh/id_ed25519.pub
SSH_TYPE=ed25519
GH_USER=rgbatty
WORKSPACE="$HOME/dev"
HOST_FILE_LOCATION="$DOTFILES_LOCATION/.nix-host"
DOTFILES_LOCATION="$HOME/.dotfiles"
XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-"$HOME"/.config}

UNAME=$(uname | tr "[:upper:]" "[:lower:]")

case $UNAME in
  'darwin')
    SYSTEM="darwin"
  ;;
  'linux')
    if [ -f /etc/lsb-release -o -d /etc/lsb-release.d ]; then
      SYSTEM=$(lsb_release -i | cut -d: -f2 | sed s/'^\t'//)
    # Otherwise, use release info file
    else
      SYSTEM=$(ls -d /etc/[A-Za-z]*[_-][rv]e[lr]* | grep -v "lsb" | cut -d'/' -f3 | cut -d'-' -f1 | cut -d'_' -f1)
    fi
  ;;
  *)
    SYSTEM=$UNAME
  ;;
  esac

SYSTEM=$(echo $SYSTEM | tr "[:upper:]" "[:lower:]")

case $SYSTEM in
  'darwin')
    NIX_DAEMON=true
    PKG_MANAGER='brew'
  ;;
  'ubuntu')
    PKG_MANAGER='apt'
  ;;
  *)
  ;;
esac

# Logging

log_system() {
  log_info "[System Details: $SYSTEM running $PKG_MANAGER]"
}

log_info() {
  # shellcheck disable=SC2059
  printf '\r  [ \033[00;34m..\033[0m ] %s\n' "$1"
}

log_success() {
  # shellcheck disable=SC2059
  printf '\r\033[2K  [ \033[00;32mOK\033[0m ] %s\n' "$1"
}

log_warn() {
  # shellcheck disable=SC2059
  printf '\r\033[2K  [ \033[01;33mWARN\033[0m ] %s\n' "$1"
}

log_fail() {
  # shellcheck disable=SC2059
  printf '\r\033[2K  [\033[0;31mFAIL\033[0m] %s\n' "$1" 1>&2
  kill -SIGINT $$
}

# Utility

append_if_absent() {
  line="$1"
  file="$2"

  # Append if absent
  touch "$file"
  grep --quiet --fixed-strings -- "$line" "$file" || echo "$line" >>"$file"
}

cmd_exists() {
  eval $1 >/dev/null
}

install() {
  local app=$1
  local cmd=${2:-"command -v $1"}

  if cmd_exists "$cmd"; then
    log_success "$app installed!"
  else
    log_info "$app is not installed. Installing $app"
    install_$app
    (cmd_exists "$cmd" && log_success "$app installed!") || log_fail "Couldn't install $app! Terminating."
  fi
}

press_to_continue() {
  log_warn 'Press enter to continue, ctrl+c to abort'
  read _

  # TODO: Add press_to_continue functionality
}

restart_nix_daemon() {
  log_info 'Restarting Nix Daemon'
  systemctl restart nix-daemon.service
}

# Installers

install_batt() {
  log_info 'Batt install placeholder'
}

install_brew() {
  echo "installing brew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

install_make() {
  sudo $PKG_MANAGER install make
}

install_nix() {
  daemonFlag=$(if ["$NIX_DAEMON" = true]; then echo "--daemon"; else echo "--no-daemon"; fi)
  (curl -L https://nixos.org/nix/install | sh -s -- $daemonFlag --yes)

  . $HOME/.nix-profile/etc/profile.d/nix.sh
}

install_nix_darwin() {
  nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
  ./result/bin/darwin-installer
}

install_nix_flakes() {
  mkdir -p "$XDG_CONFIG_HOME"/nix
  append_if_absent 'experimental-features = nix-command flakes' "$XDG_CONFIG_HOME"/nix/nix.conf
  (["$NIX_DAEMON" = true] && restart_nix_daemon)
}

install_xcode() {
  xcode-select --install
}

# Script

# TODO: Decide on Batt implementation (alias for Just?)
# verify_batt() {
#   install_batt
# }

verify_deps_darwin() {
  install xcode 'xcode-select -p'
  install brew
  verify_deps_unix
  verify_nix
  install nix_darwin 'command -v /run/current-system/sw/bin/darwin-rebuild'
}

verify_deps_ubuntu() {
  verify_deps_unix
  verify_nix
}

verify_deps_unix() {
  install make
}

# TODO: Decide on whether or not host value should be selectable/preset
# verify_host() {
#   log_info 'Nix Host Type - Checking...'

#   if [ ! -f "$HOST_FILE_LOCATION" ]; then
#     log_info 'Nix Host Type - Setting up...'
#     nix_host=
#     select nix_host in $(find "$DOTFILES_LOCATION/profiles/hosts/" -mindepth 1 -type d -exec basename {} \; | xargs); do
#        test -n "$nix_host" && break
#        log_warn "Invalid host!"
#     done
#     printf '%s' "$nix_host" >>"$HOST_FILE_LOCATION"
#   fi

#   log_success "Nix Host Type - Set to '$(cat "$HOST_FILE_LOCATION")'!"
# }

verify_nix() {
  install nix
  install nix_flakes 'nix flake show templates'
}

verify_repo() {
  if [ ! -d "$DOTFILES_LOCATION" ]; then
    log_info 'Cloning Cauldron'
    git clone git@github.com:$GH_USER/cauldron.git "$DOTFILES_LOCATION"
  fi

  log_success 'Cauldron repository verified!'
}

verify_ssh() {
  if [ -f "$SSH_KEY_LOCATION" ]; then
    log_info "'$SSH_KEY_LOCATION' already exists"
  else
    ssh-keygen -t $SSH_TYPE -C "$SSH_KEY_EMAIL_ADDRESS"
    log_info "Generated $SSH_TYPE SSH key for $SSH_KEY_EMAIL_ADDRESS"

    case $HOST in
      'darwin')
        cat "$SSH_KEY_LOCATION" | pbcopy
        log_info 'Public key saved to clipboard'
        open https://github.com/settings/ssh/new
      ;;
      *)
        log_info 'Printing out public key.'
        cat "$SSH_KEY_LOCATION"
        log_warn 'Please copy public key to https://github.com/settings/ssh/new'
      ;;
    esac

    press_to_continue
  fi

  log_success 'SSH details verified!'
}

log_info '~~Double Double, Toil and Trouble... Cauldron Burn and Fire Bubble!~~'
log_system
log_info 'Please check the above details look correct before continuing.'
press_to_continue

"verify_deps_${SYSTEM}"
verify_ssh
verify_repo
# verify_batt
# verify_host

log_success 'Bootstrap completed. Run `batt` for more information.'
