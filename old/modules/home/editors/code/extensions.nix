{ pkgs }:

with pkgs.vscode-extensions; [
  # golang.go
  # gruntfuggly.todo-tree
  # ms-azuretools.vscode-docker
  # ms-vsliveshare.vsliveshare
  
  christian-kohler.path-intellisense
  dbaeumer.vscode-eslint
  dracula-theme.theme-dracula
  eamodio.gitlens
  esbenp.prettier-vscode
  jnoortheen.nix-ide
  mikestead.dotenv
  rebornix.ruby
  skellock.just
  skyapps.fish-vscode
  wingrunr21.vscode-ruby
] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
  {
    name = "better-comments";
    publisher = "aaron-bond";
    version = "3.0.2";
    sha256 = "sha256-hQmA8PWjf2Nd60v5EAuqqD8LIEu7slrNs8luc3ePgZc";
  }
  {
    name = "vscode-markdownlint";
    publisher = "DavidAnson";
    version = "0.51.0";
    sha256 = "sha256-Xtr8cqcPrcrKpJBxQcY1j9Gl4CC6U3ZazS4bdBtdzUk";
  }
  {
    name = "endwise";
    publisher = "kaiwood";
    version = "1.5.1";
    sha256 = "sha256-5NYgpl4VVEB+/j4nHyqQHihfBIzj5HFr9DqObZtJ4LU";
  }
  {
    name = "ruby-rubocop";
    publisher = "misogi";
    version = "0.8.6";
    sha256 = "sha256-6hgJzOerGCCXcpADnISa7ewQnRWLAn6k6K4kLJR09UI";
  }
  {
    name = "material-icon-theme";
    publisher = "PKief";
    version = "4.30.1";
    sha256 = "sha256-ibRGROhFOxZ5koFwSaDOkFqYKM/LpR8axnW9XvMuYJU";
  }

  # {
  #   name = "trailing-spaces";
  #   publisher = "shardulm94";
  #   version = "0.3.1";
  #   sha256 = "0h30zmg5rq7cv7kjdr5yzqkkc1bs20d72yz9rjqag32gwf46s8b8";
  # }
]
