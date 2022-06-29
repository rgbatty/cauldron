{
  programs.git = {
    enable = true;

    # TODO: Configure username and email for git
    # userEmail = "";
    # userName = "";

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
      };

      fetch.prune = true;

      init.defaultBranch = "main";

      merge.log = true;

      push.default = "current";

      rebase.autostash = true;

      status.submoduleSummary = true;

      # user.email = "";
      # user.name = "";

      # Environment variables will not be expanded -- this requires a path.
      # init.templateDir = "${config.xdg.configHome}/git/templates";

      # Result: <short-sha> <commit-message> (<pointer-names>) -- <commit-author-name>; <relative-time>
      # pretty.nice = "%C(yellow)%h%C(reset) %C(white)%s%C(cyan)%d%C(reset) -- %an; %ar";
    };

    # TODO: Move to its own file
    ignores = [
      ".yarn"
      "node_modules"

      # Logs and databases
      "*.sql"
      "*.sqlite"
      ".log"

      # OS or Editor files
      "._*"
      ".DS_Store"
      ".DS_Store?"
      "ehthumbs.db"
      "Thumbs.db"
      ".tern-project"

      # Files that might appear on external disks
      ".Spotlight-V100"
      ".DocumentRevisions-V100"
      ".fseventsd"
      ".TemporaryItems"
      ".Trashes"
      ".VolumeIcon.icns"
      ".com.apple.timemachine.donotpresent"

      # Directories potentially created on remote AFP share
      ".AppleDB"
      ".AppleDesktop"
      "Network Trash Folder"
      "Temporary Items"
      ".apdisk"

      # Always-ignore extensions
      "*~"
      "*.err"
      "*.orig"
      "*.pyc"
      "*.rej"
      "*.sw?"
      "*.vi"
      "*.bak"

      # Credentials and Sensitive Info
      ".env"
      ".direnv"
      ".scratch"
      "*localrc"
      "*.local"
    ];

    aliases = {

      # logging
      plog =
        "log --graph --pretty='format:%C(red)%d%C(reset) %C(yellow)%h%C(reset) %ar %C(green)%aN%C(reset) %s'";
      tlog =
        "log --stat --since='1 Day Ago' --graph --pretty=oneline --abbrev-commit --date=relative";
      rank = "shortlog -sn --no-merges";
    };
  };

  programs.gh.enable = true;
  programs.gh.settings.git_protocol = "ssh";
  # xdg.configFile."git/templates".source = "${pkgs.dotfield-config}/git/templates";
}
