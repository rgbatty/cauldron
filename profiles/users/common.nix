{ config, ... }:
let
in {
  modules = {
    # desktop = {
    #   apps = {
    #     unity3d.enable = true;
    #   };

    #   browsers = {
    #     firefox.enable = true;
    #     vivaldi.enable = true;
    #   };

    #   gaming = {
    #     steam.enable = true;
    #   };

    #   media = {
    #     recording.enable = true;
    #     spotify.enable = true;
    #   };

    #   term = {
    #     iterm.enable = true;
    #     winterm.enable = true;
    #   };
    # };

    # dev = {
    #   elixir.enable = true;
    #   go.enable = true;
    #   node.enable = true;
    #   python.enable = true;
    #   ruby.enable = true;
    #   rust.enable = true;
    # };

    # editors = {
    #   emacs.enable = true;
    #   vim.enable = true;
    #   vscode.enable = true;
    # };

    # hardware = {
    #   qmk.enable = true;
    #   zmk.enable = true;
    # };

    git.enable = true;

    services = {
      ssh.enable = true;
      # docker.enable = true;
      # vaultwarden.enable = true;
    };

    shell = {
      bash.enable = true;
      fish.enable = true;
      zsh.enable = true;

      utilities = {
        bat.enable = true;
        exa.enable = true;
        fzf.enable = true;
        navi.enable = true;
        zoxide.enable = true;
      };
    };
  };

  # fonts.fonts = with pkgs; [ powerline-fonts dejavu_fonts ];
    # fonts-firacode
}
