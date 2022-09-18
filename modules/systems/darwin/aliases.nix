{
  ## Darwin
  # =================================================================

  # Lists drive mounts.
  mnt="mount | grep -E ^/dev | column -t";

  # Shuts down the system.
  poweroff="osascript -e 'tell application \"System Events\" to shut down'";

  # Restarts the system.
  reboot="osascript -e 'tell application \"System Events\" to restart'";

  # Hibernates the system.
  hibernate="pmset sleep now";

  # Locks the session.
  lock="pmset displaysleepnow";

  # Flushes the DNS cache.
  flushdns="dscacheutil -flushcache; sudo killall -HUP mDNSResponder;echo DNS cache flushed";

  # Gets local IP address.
  localip="ipconfig getifaddr en0";

  browse="open";
  chrome="open -a Google\ Chrome";
  edge="open -a Microsoft\ Edge";
  firefox="open -a Firefox";
  opera="open -a Opera";
  safari="open -a Safari";

  # # Toggles display of desktop icons.
  hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder";
  showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder";

  # # Toggles hidden files in Finder.
  hidefiles="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder";
  showfiles="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder";

  # # Toggles Spotlight.
  spotoff="sudo mdutil -a -i off";
  spoton="sudo mdutil -a -i on";

  # # Get macOS Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
  update="sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm install npm -g; npm update -g; sudo gem update --system; sudo gem update; sudo gem cleanup";

  # # Clean up LaunchServices to remove duplicates in the “Open With” menu
  lscleanup="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder";

  # # Recursively delete `.DS_Store` files
  cleanup="find . -type f -name "*.DS_Store" -ls -delete";

  # # Empty the Trash on all mounted volumes and the main HDD.
  # # Also, clear Apple’s System Logs to improve shell startup speed.
  # # Finally, clear download history from quarantine. https://mths.be/bum
  emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'";

  # # Airport CLI alias
  airport="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport";

  # # Stuff I never really use but cannot delete either because of http://xkcd.com/530/
  stfu="osascript -e 'set volume output muted true'";
  pumpitup="osascript -e 'set volume output volume 10'";

  # # PlistBuddy alias, because sometimes `defaults` just doesn’t cut it
  plistbuddy="/usr/libexec/PlistBuddy";
}
