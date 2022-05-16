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

# display the status bar on Finder
defaults write com.apple.finder ShowStatusBar -bool true

# display the path bar in Finder
defaults write com.apple.finder ShowPathbar -bool true

# display the battery level in machine's menu bar
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

for app in "Dock" \
	"Finder" \
	"SystemUIServer"; do
	killall "${app}" &> /dev/null
done

