{
  # shellAliases = with pkgs; {
    #   cat = "${bat}/bin/bat";
    #   ls = "${exa}/bin/exa";
    #   find = "${fd}/bin/fd";
    # };
  ## Colorization
  # =================================================================

  # Colorizes diff output, if possible.
  # if type "colordiff" &> /dev/null; then
  #     diff = "colordiff"
  # fi

  # Colorizes listings.
  # if ls --color &> /dev/null; then
  #   # GNU `ls` package
  #   colorflag = "--color=auto"
  #   export LS_COLORS = "no=00:fi=00:di=01;31:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:"
  # else
  #   # macOS `ls` package
  #   colorflag="-G"
  #   export LSCOLORS = "BxBxhxDxfxhxhxhxhxcxcx"
  # fi

  # if type "dir" &> /dev/null; then
  #     dir = "dir --color=auto"
  # fi

  # if type "vdir" &> /dev/null; then
  #     vdir = "vdir --color=auto"
  # fi

  # Colorizes the `grep` output.
  grep = "grep --color=auto";
  egrep = "egrep --color=auto";
  fgrep = "fgrep --color=auto";

  ## File Management
  # =================================================================

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
  ls = "command ls -Fh \${colorflag}";


  # Finds directories.
  fd = "find . -type d -name";

  # Finds files.
  ff = "find . -type f -name";

  ## Shell
  # =================================================================

  # Reloads the shell.
  reload = "exec $SHELL -l";

  # Enables simple aliases to be sudo"ed.
  # See http://www.gnu.org/software/bash/manual/bashref.html#Aliases
  sudo = "sudo ";

  # Prints each $PATH entry on a separate line.
  path = "echo -e \${PATH//:/\\n}";

  # Reloads the configuration.
  # if [ -n "$ZSH_VERSION" ]; then
  #     resource=". $HOME/.zshrc"
  # else
  #     resource=". $HOME/.bash_profile"
  # fi

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

  # Displays information about the system.
  # for command in winfetch neofetch screenfetch; do
  #   if type $command &> /dev/null; then
  #         sysinfo="$command"
  #       break
  #   fi
  # done

  # # TODO Add clipboard alias
  # # Pastes the contents of the clipboard.
  # if command -v pbpaste > /dev/null; then
  #     cbpaste="pbpaste"
  # elif command -v xclip > /dev/null; then
  #     cbpaste="xclip -i -selection clipboard -o"
  # elif command -v xsel > /dev/null; then
  #     cbpaste="xsel -bo"
  # elif command -v clipboard > /dev/null; then
  #     cbpaste="clipboard"
  # elif command -v powershell > /dev/null; then
  #     cbpaste="powershell -NoProfile -Command "Get-Clipboard""
  # fi


  ## Network
  # =================================================================

  # Stops ping after sending 4 ECHO_REQUEST packets.
  ping = "ping -c 4";

  # Pings hostname(s) 30 times in quick succession.
  fastping = "ping -c 30 -i.2";

  # Gets all IP addresses.
  ips = "ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'";

  # Gets external IP address.
  publicip="curl --silent --compressed --max-time 5 --url 'https://ipinfo.io/ip'";

  # Show active network interfaces
  ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'";

  # Sends HTTP requests.
  # command -v lwp-request &> /dev/null && for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
  #   #shellcheck disable=SC2139
  #     $method="lwp-request -m "$method""
  # done
  # unset method;

  ## Editors
  # =================================================================

  # Sets editors and defaults.
  edit = "vim";
  svi = "sudo vi";
  vi = "vim";
  vis = "vim '+set si'";

  # Disables wrapping of long lines in Nano.
  nano = "nano -w";

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
  weather="curl --silent --compressed --max-time 10 --url 'https://wttr.in/?format=%l:+(%C)+%c++%t+\[%h,+%w\]'";

  # # Calculates MD5 hashes.
  # if ! command -v md5sum > /dev/null; then
  #   if command -v md5 > /dev/null; then
  #         md5sum="md5 -r"
  #   else
  #         md5sum="openssl md5 -r"
  #   fi
  # fi

  # # Calculates SHA1 hashes.
  # if ! command -v sha1sum > /dev/null; then
  #   if command -v shasum > /dev/null; then
  #         sha1sum="shasum -a 1 -p"
  #   else
  #         sha1sum="openssl sha1 -r"
  #   fi
  # fi

  # # Calculates SHA256 hashes.
  # if ! command -v sha256sum > /dev/null; then
  #   if command -v shasum > /dev/null; then
  #         sha256sum="shasum -a 256 -p"
  #   else
  #         sha256sum="openssl sha256 -r"
  #   fi
  # fi

  # # URL-encode strings
  urlencode="python -c 'import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);'";

  # Merge PDF files, preserving hyperlinks
  # Usage: `mergepdf input{1,2,3}.pdf`
  mergepdf = "gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=_merged.pdf";

  ## User Directories
  # =================================================================

  # Navigates to user paths.
  # dl="cd  .home_dir/Downloads"
  # docs="cd  .home_dir/Documents"
  # dt="cd  .home_dir/Desktop"

  # # TODO Add personal aliases
  # # Navigates to custom paths.
  # dev="cd .project_dir"
}
