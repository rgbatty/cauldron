{ config, lib, pkgs, ... }:
let
  # TODO: Update git templates
  commit-templates = {
    conventional = pkgs.writeText "gitmessage-conventional" ''
      # <type>(<scope>): <subject>
      # types: feat, fix, docs, style, refactor, test, chore
      # scope: arbitrary by project
      # subject: imperative tense, no capital, no period
      #
      # body: imperative tense, include motivation for the change and contrasts with previous behavior
      #
      # footer: BREAKING CHANGE, issue references (closes #12345)
      # https://github.com/clog-tool/clog-cli/tree/bd3e45fdc8674e5f9a03a5136760dff0657817d6#about
      # https://github.com/conventional-changelog/conventional-changelog/blob/a5505865ff3dd710cf757f50530e73ef0ca641da/conventions/angular.md
    '';

    dotfiles = pkgs.writeText "gitmessage-dotfiles" ''
      # categories: "", security, break, feature, fix, add, remove, deprecate
      # scopes: "", asdf, brew, doc, emacs, homemanager, nix
    '';
  };

  configIncludes = {
    conventionalCommits = {
      commit = { template = commit-templates.conventional.outPath; };
    };

    dotfiles = { commit = { template = commit-templates.dotfiles.outPath; }; };
  };
in {
  home.packages = with pkgs;
  [
    git
  ] ++ (with pkgs.gitAndTools; [
    gh
  ]);

  programs.git = {
    enable = true;
    # TODO: Add dynamic git user
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

    ignores = [];

    aliases = {
      # logging
      plog =
        "log --graph --pretty='format:%C(red)%d%C(reset) %C(yellow)%h%C(reset) %ar %C(green)%aN%C(reset) %s'";
      tlog =
        "log --stat --since='1 Day Ago' --graph --pretty=oneline --abbrev-commit --date=relative";
      rank = "shortlog -sn --no-merges";
    };

    # TODO: Add gitignore_global
    # xdg.configFile = {
    #   "git/config.conventional".text =
    #     generators.toINI { } configIncludes.conventionalCommits;
    #   "git/config.dotfiles".text =
    #       generators.toINI { } configIncludes.dotfiles;
    #   # "git/.gitignore_global".so = "";
    # };
  };

  programs.gh.enable = true;
  programs.gh.settings.git_protocol = "ssh";
  # xdg.configFile."git/templates".source = "${pkgs.dotfield-config}/git/templates";
}
