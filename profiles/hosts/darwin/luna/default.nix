{ inputs, lib, config, flake, pkgs, home-manager, ... }: {
  users.users.rbatty = {
    home = "/Users/rbatty";
    shell = pkgs.fish;
  };

  home-manager.users.rbatty = {
    imports = [ ../../users/rbatty ];
  };
}

