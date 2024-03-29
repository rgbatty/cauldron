{ pkgs }:

with pkgs.vscode-extensions; [
  bbenoist.nix
  christian-kohler.path-intellisense
  dbaeumer.vscode-eslint
  dracula-theme.theme-dracula
  eamodio.gitlens
  esbenp.prettier-vscode
  golang.go
  gruntfuggly.todo-tree
  # ms-azuretools.vscode-docker
  # ms-vsliveshare.vsliveshare
  pkief.material-icon-theme
  skellock.just
  skyapps.fish-vscode
] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
  {
    name = "better-comments";
    publisher = "aaron-bond";
    version = "3.0.2";
    sha256 = "15w1ixvp6vn9ng6mmcmv9ch0ngx8m85i1yabxdfn6zx3ypq802c5";
  }
  # YAML

  # Endwise

  # Ruby

  # Rubocop

  # Solargraph

  # {
  #   name = "trailing-spaces";
  #   publisher = "shardulm94";
  #   version = "0.3.1";
  #   sha256 = "0h30zmg5rq7cv7kjdr5yzqkkc1bs20d72yz9rjqag32gwf46s8b8";
  # }
]
