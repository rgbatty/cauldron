{
  programs.ssh = {
    enable = true;

    matchBlocks = {
      "*" = {
        extraOptions = {
          controlMaster = "auto";
          controlPath = "~/.ssh/controlmasters/%r@%h:%p";
          controlPersist = "5";

          addKeysToAgent = "yes";
          useKeychain = "yes";

          serverAliveCountMax = "6";
          serverAliveInterval = "300";
        };
      };
    };
  };
}
