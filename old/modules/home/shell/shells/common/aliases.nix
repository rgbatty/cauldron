{
  ## File Management
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

  # quick cd
  ".." = "cd ..";
  "..." = "cd ../..";
  "...." = "cd ../../..";
  "....." = "cd ../../../..";

  # Makes file commands verbose.
  cp = "cp -v";
  mv = "mv -v";

  # Copies a file securely.
  cpv = "rsync -ah --info=progress2";

  # Creates parent directories on demand.
  mkdir = "mkdir -pv";

  ## File Navigation
  # =================================================================

  # Uses human sizes, classifications, and color output for `ls`.
  # ls = "command ls -Fh \${colorflag}";

  # Finds directories.
  fd = "find . -type d -name";

  # Finds files.
  ff = "find . -type f -name";

  ## Shell
  # =================================================================

  # Clears the console screen.
  c = "clear";

  # Reloads the shell.
  reload = "exec $SHELL -l";

  # Enables simple aliases to be sudo"ed.
  # See http://www.gnu.org/software/bash/manual/bashref.html#Aliases
  sudo = "sudo ";

  # Prints each $PATH entry on a separate line.
  # path = "echo -e \${PATH//:/\\n}";

  ## System
  # =================================================================

  # Makes `mount` command output pretty and with a human readable format.
  mount = "mount | column -t";

  # Displays drives and space in human readable format.
  df = "df -h";

  # Prints disk usage per directory non-recursively, in human readable format.
  du = "du -h -d1";

  # Intuitive map function
  # For example, to list all directories that contain a certain file:
  # find . -name .gitattributes | map dirname
  map="xargs -n1";

  ## Network
  # =================================================================

  # Stops ping after sending 4 ECHO_REQUEST packets.
  ping = "ping -c 4";

  # Pings hostname(s) 30 times in quick succession.
  fastping = "ping -c 30 -i.2";

  # Gets all IP addresses.
  # ips = "ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'";

  # Gets external IP address.
  publicip="curl --silent --compressed --max-time 5 --url 'https://ipinfo.io/ip'";

  # Show active network interfaces
  # ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'";

  # Sends HTTP requests.
  # command -v lwp-request &> /dev/null && for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
  #   #shellcheck disable=SC2139
  #     $method="lwp-request -m "$method""
  # done
  # unset method;

  ## Utilities
  # =================================================================

  # Gets local/UTC date and time in ISO-8601 format `YYYY-MM-DDThh:mm:ss`.
  now = "date +'%Y-%m-%dT%H:%M:%S'";
  unow = "date -u +'%Y-%m-%dT%H:%M:%S'";

  # Gets date in `YYYY-MM-DD` format`
  nowdate = "date +'%Y-%m-%d'";
  unowdate = "date -u +'%Y-%m-%d'";

  # Gets time in `hh:mm:ss` format`
  nowtime = "date +'%T'";
  unowtime = "date -u +'%T'";

  # Gets Unix time stamp`
  timestamp = "date -u +%s";

  # Gets week number in ISO-8601 format `YYYY-Www`.
  week = "date +'%Y-W%V'";

  # Gets weekday number.
  weekday = "date +'%u'";

  # Displays detailed weather and forecast.
  forecast="curl --silent --compressed --max-time 10 --url 'https://wttr.in?F'";

  # Displays current weather.
  weather="curl --silent --compressed --max-time 10 --url 'https://wttr.in/?format=%25l:+(%25C)+%25c++%25t+%5B%25h,+%25w%5D'";

  ## User Directories
  # =================================================================

  # Navigates to user paths.
  # dl="cd  .home_dir/Downloads"
  # docs="cd  .home_dir/Documents"
  # dt="cd  .home_dir/Desktop"

  # # Navigates to custom paths.
  # dev="cd .project_dir"
}
