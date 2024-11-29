inputs: { lib, config, flake, pkgs, home-manager, ... }: let 
  rbatty = import "${inputs.self}/profiles/users/rbatty" inputs;
in {
  users.users.rbatty = {
    # shell = pkgs.fish;
    home = "/Users/rbatty";
  };

  home-manager.users.rbatty = {
    home.username = "rbatty";
    home.homeDirectory = "/Users/rbatty";
    imports = [ rbatty ];
  };

  modules.systems.darwin = {
    apps.brew = {
      enable = true;
      taps = [
        # "homebrew/cask"
        "homebrew/cask-versions"
        # "homebrew/core"
        "homebrew/services"
        "koekeishiya/formulae"
      ];
      brews = [
        "coreutils"
        "graphviz" # work req - should move into its own profile
        "postgresql@14"
        "openssl@1.1"
        "readline"
        "libyaml"
        "libpq"
        "gmp"
        "gpg"
      ];
      casks = [
        # "docker" tmp disable until new profile for work
        "obsidian"
        # "vivaldi"
      ];
    };

    services = {
      skhd.enable = true;
      yabai.enable = true;
    };
  };
}
