{
  ## File Navigation
  # =================================================================

  # Lists visible files in long format.
  l = "ls -l";

  # Lists all files in long format, excluding `.` and `..`.
  ll = "ls -lA";

  # Lists directories only, in long format.
  lsd = "ls -l | grep --color=never '^d'";

  # Lists hidden files in long format.
  lsh = "ls -dlA .?*";

  # Nagivates to the last used directory.
  "cd-" = "cd -";
  "-- -" = "cd -";

  # quick cd
  ".." = "cd ..";
  "..." = "cd ../..";
  "...." = "cd ../../..";
  "....." = "cd ../../../..";

  ## Shell
  # =================================================================

  # Clears the console screen.
  c = "clear";

  ## Containers
  # =================================================================

  # Creates shortcuts for Docker.
  dk = "docker";
  dco = "docker-compose";

  ## Git
  # =================================================================

  # Creates shortcut for Git.
  g = "git";

  # add / checkout / reset
  gf = "git fetch -p";
  ga = "git add";
  gap = "git add -p";
  grs = "git reset";
  gco = "git checkout";
  gcob = "git checkout -b";

  # branches
  gb = "git branch";
  gba = "git branch -a";
  gbd = "git branch -d";
  gbD = "git branch -D";
  # delete merged branches
  gbdm = "!git branch --merged | grep -v '*' | xargs -n 1 git branch -d";

  # commit
  gc = "git commit";

  # pull / push
  gpl = "git pull";
  gplo = "git pull origin";
  gps = "git push";
  gpsu = "git push -u";
  gpso = "git push origin";

  # status / diff / difftool
  gs = "git status -sb";
  gd = "git diff";
  gdc = "git diff --cached";
  gds = "git diff --staged";
  gdt = "git difftool";
  # Show list of files changed in a specified commit or other ref
  gdl = "git diff-tree --no-commit-id --name-only -r";

  # stash
  gsh = "git stash";
  gsha = "git stash apply";
  gshp = "git stash pop";
  gshl = "git stash list";

  # log
  gl = "git log --oneline --decorate -20";
  # List all the commits on the current branch ahead of master.
  # glb="git log --oneline --decorate ${GIT_PRIMARY_BRANCH:-main}..${GIT_BRANCH_NAME:-HEAD}"
  # "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

  # submodule
  # Magical fix for all submodule issues.
  gsumo = "git submodule update --init --recursive";

  ## Nix
  # =================================================================

  # nix
  n = "nix";
  np = "n profile";
  ni = "np install";
  nr = "np remove";
  ns = "n search --no-update-lock-file";
  nf = "n flake";
  nepl = "n repl '<nixpkgs>'";
  srch = "ns nixos";
  orch = "ns override";
  mn = ''
    manix "" | grep '^# ' | sed 's/^# \(.*\) (.*/\1/;s/ (.*//;s/^# //' | sk --preview="manix '{}'" | xargs manix
  '';
}
