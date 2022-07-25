{ config, ... }: {
  modules = {
    home = {
      editors = {
        vim.enable = true;
      };

      services = {
        ssh.enable = true;
      };

      shell = {
        git.enable = true;

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
  };
}
