#!/bin/zsh

set -xe

if [ "$(uname)" != "Darwin" ]; then
	echo "This machine is not macOS!"
	exit 1
fi

# disable "press and hold" configuration
defaults write -g ApplePressAndHoldEnabled -bool false

# show files with their extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# show all extensions
defaults write -g AppleShowAllExtensions -bool true

# display the status bar on Finder
defaults write com.apple.finder ShowStatusBar -bool true

# display the path bar in Finder
defaults write com.apple.finder ShowPathbar -bool true

# display the battery level in machine's menu bar
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# disable correcting spellings
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false

# don't make .DS_Store files
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# setup google's DN
networksetup -setdnsservers Wi-Fi 2001:4860:4860::8844 2001:4860:4860::8888 8.8.4.4 8.8.8.8

# mouse setups
defaults write com.apple.mouse.scaling 5

# dock setups
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize -int 36 && killall Dock

for app in "Dock" \
	"Finder" \
	"SystemUIServer"; do
	killall "${app}" &>/dev/null
done
