# TODO: Git Configuration
# * Implement aliases (system & git-specific, ideally)
# * implement commit templating
# * use user information
# * colorize/theme using themes
# * pretty.nice?

{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.home.shell.git;
in {
  options.modules.home.shell.git = with types; {
    enable = mkEnableOption "git";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gitAndTools.gh
    ];

    programs.git = {
      enable = true;
      userName = "Ryan Batty";
      userEmail = "rbatty@koumori.dev";

      includes = [
        {
          path = "${config.xdg.configHome}/git/config.dotfiles";
          condition = "gitdir:~/.dotfiles/";
        }
        {
          path = "${config.xdg.configHome}/git/config.conventional";
          condition = "gitdir:~/src/side-projects/";
        }
      ];

      # ignores = [];
      # aliases = {};
      # xdg.configFile."git/templates".source = "/git/templates";

      extraConfig = {
        branch.sort = "-committerdate";

        color = {
          ui = "auto";

          branch = {
            current = "yellow reverse";
            local = "yellow";
            remote = "green";
          };

          diff = {
            meta = "yellow bold";
            frag = "magenta bold";
            old = "red";
            new = "green";
          };

          status = {
            added = "yellow";
            changed = "green";
            untracked = "cyan";
          };
        };

        core = {
          # Treat spaces before tabs and all kinds of trailing whitespace as an error.
          # [default] trailing-space: looks for spaces at the end of a line
          # [default] space-before-tab: looks for spaces before tabs at the beginning of a line
          whitespace = "space-before-tab,-indent-with-non-tab,trailing-space";

          # Disable line endings output conversion.
          autocrlf = "input";

          # Make `git rebase` safer on macOS.
          # See http://www.git-tower.com/blog/make-git-rebase-safe-on-osx/
          trustctime = false;

          # Speed up commands involving untracked files such as `git status`.
          # See https://git-scm.com/docs/git-update-index#_untracked_cache
          untrackedCache = true;

          excludesFile = "${config.xdg.configHome}/git/.gitignore_global";
        };

        fetch.prune = true;
        init.defaultBranch = "main";
        merge.log = true;
        push.default = "current";
        rebase.autostash = true;
        status.submoduleSummary = true;

        # Environment variables will not be expanded -- this requires a path.
        # init.templateDir = "${config.xdg.configHome}/git/templates";

        # Result: <short-sha> <commit-message> (<pointer-names>) -- <commit-author-name>; <relative-time>
        # pretty.nice = "%C(yellow)%h%C(reset) %C(white)%s%C(cyan)%d%C(reset) -- %an; %ar";
      };
    };

    programs.gh.enable = true;
    programs.gh.settings.git_protocol = "ssh";
  };
}
