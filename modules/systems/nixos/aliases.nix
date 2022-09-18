{
  ## Linux
  # =================================================================

  # Lists drive mounts.
  mnt="mount | awk -F' ' '{ printf \"%s\t%s\n\",\$1,\$3; }' | column -t | egrep ^/dev/ | sort";

  # Shuts down the system.
  poweroff="sudo /sbin/poweroff";

  # Restarts the system.
  reboot="sudo /sbin/reboot";

  # Hibernates the system.
  hibernate="systemctl suspend";

  # Locks the session.
  # if command -v vlock &> /dev/null; then
  #     lock="vlock --all"
  # elif command -v gnome-screensaver-command &> /dev/null; then
  #     lock="gnome-screensaver-command --lock"
  # fi

  # Gets local IP address.
  localip="ip route get 1 | awk '{print \$NF;exit}'";

  browse="x-www-browser"; #xdg-open
  chrome="chromium";
  edge="microsoft-edge";
  firefox="firefox";
  opera="opera";
  safari="safari";

  ## WSL
  # =================================================================

  # Shuts down the system.
  # poweroff="shutdown.exe /s"

  # Restarts the system.
  # reboot="shutdown.exe /r"

  # Hibernates the system.
  # hibernate="shutdown.exe /h"

  # Locks the session.
  # lock="rundll32.exe user32.dll,LockWorkStation"

  # Flushes the DNS cache.
  # flushdns="ipconfig //flushdns"

  # Flushes the DNS cache.
  # flushdns="sudo /etc/init.d/dns-clean restart && echo DNS cache flushed"

  # Gets local IP address.
  # # shellcheck disable=SC2142
  # localip="netstat -rn | grep -w "0.0.0.0" | awk "{ print \$4 }""
}
