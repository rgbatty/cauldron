{ config, ... }: {
  modules = {
    git.enable = true;

    services = {
      ssh.enable = true;
    };

    shell = {
      shells = {
        bash.enable = true;
        fish.enable = true;
        zsh.enable = true;
      };

      starship.enable = true;

      utilities = {
        enable = true;
        modern = true;
        navi = true;
      };
    };
  };
}
