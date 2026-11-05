#!/usr/bin/env bash
# Idempotent; each step may fail without stopping the rest.

# Ctrl/Cmd swap on the built-in keyboard and the ZSA boards (vendor 12951, products 6505/6519).
# Applies after next login or keyboard replug. Do not also set a hidutil UserKeyMapping: it would swap twice.
LCTRL=30064771296 LCMD=30064771299 RCTRL=30064771300 RCMD=30064771303
map() { echo "<dict><key>HIDKeyboardModifierMappingSrc</key><integer>$1</integer><key>HIDKeyboardModifierMappingDst</key><integer>$2</integer></dict>"; }
swap() {
  defaults -currentHost write -g "com.apple.keyboard.modifiermapping.$1" -array \
    "$(map $LCMD $LCTRL)" "$(map $RCTRL $RCMD)" "$(map $RCMD $RCTRL)" "$(map $LCTRL $LCMD)" || true
}
hotkey_off() { defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add "$1" '<dict><key>enabled</key><false/></dict>' || true; }
swap 0-0-0
swap 12951-6505-0
swap 12951-6519-0

# Symbolic hotkeys: off (Spotlight, screenshots, Mission Control, space/input-source switching, Cmd-`,
# Ctrl-F focus, tiling); Switch to Desktop 1-10 on Option+1...0.
# hotkey <id> <enabled 0|1> <p1> <p2> <p3>; typed XML so values stay bool/int (old-style {..} syntax stores strings and crashes activateSettings)
hotkey() {
  local en=false; [ "$2" = 1 ] && en=true
  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add "$1" \
    "<dict><key>enabled</key><$en/><key>value</key><dict><key>parameters</key><array><integer>$3</integer><integer>$4</integer><integer>$5</integer></array><key>type</key><string>standard</string></dict></dict>" || true
}
hotkey 64 0 32 49 1048576
hotkey 65 0 32 49 1572864
hotkey 28 0 51 20 1179648
hotkey 29 0 51 20 1441792
hotkey 30 0 52 21 1179648
hotkey 31 0 52 21 1441792
hotkey 184 0 53 23 1179648
hotkey 32 0 65535 126 8650752
hotkey 33 0 65535 125 8650752
hotkey 79 0 65535 123 8650752
hotkey 81 0 65535 124 8650752
hotkey 60 0 32 49 262144
hotkey 61 0 32 49 786432
hotkey 27 0 96 50 1048576
hotkey 7 0 65535 120 8650752
hotkey 8 0 65535 99 8650752
hotkey 9 0 65535 118 8650752
hotkey 10 0 65535 96 8650752
hotkey 11 0 65535 97 8650752
hotkey 12 0 65535 122 8650752
hotkey 13 0 65535 98 8650752
hotkey_off 36
hotkey 52 0 100 2 1572864
hotkey 233 0 109 46 1048576
hotkey 235 0 65535 65535 0
hotkey 237 0 102 3 8650752
hotkey 238 0 99 8 8650752
hotkey 239 0 114 15 8650752
hotkey 240 0 65535 123 8650752
hotkey 241 0 65535 124 8650752
hotkey 242 0 65535 126 8650752
hotkey 243 0 65535 125 8650752
hotkey 244 0 65535 65535 0
hotkey 245 0 65535 65535 0
hotkey 246 0 65535 65535 0
hotkey 247 0 65535 65535 0
hotkey 248 0 65535 123 8781824
hotkey 249 0 65535 124 8781824
hotkey 250 0 65535 126 8781824
hotkey 251 0 65535 125 8781824
hotkey 118 1 65535 18 262144
hotkey 119 1 65535 19 262144
hotkey 120 1 65535 20 262144
hotkey 121 1 65535 21 262144
hotkey 122 1 65535 23 262144
hotkey 123 1 65535 22 262144
hotkey 124 1 65535 26 262144
hotkey 125 1 65535 28 262144
hotkey 126 1 65535 25 262144
hotkey 127 1 65535 29 262144

defaults write NSGlobalDomain KeyRepeat -int 2 || true
defaults write NSGlobalDomain InitialKeyRepeat -int 15 || true
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false || true
defaults write NSGlobalDomain WebAutomaticSpellingCorrectionEnabled -bool false || true
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false || true
defaults write com.apple.HIToolbox AppleFnUsageType -int 0 || true

defaults write com.apple.dock autohide -bool true || true
defaults write com.apple.dock orientation -string right || true
defaults write com.apple.dock tilesize -int 16 || true
defaults write com.apple.dock magnification -bool true || true
defaults write com.apple.dock largesize -int 128 || true
defaults write com.apple.dock show-recents -bool false || true

defaults write -g AppleInterfaceStyle -string Dark || true
defaults write -g com.apple.swipescrolldirection -bool false || true
defaults write -g AppleEnableSwipeNavigateWithScrolls -bool false || true
defaults write -g com.apple.sound.uiaudio.enabled -int 0 || true
defaults write -g com.apple.mouse.scaling -float 1.5 || true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true || true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true || true
defaults -currentHost write -g com.apple.mouse.tapBehavior -int 1 || true

defaults write -g AppleSpacesSwitchOnActivate -bool false || true
defaults write com.apple.spaces spans-displays -bool true || true
defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false || true
defaults write com.apple.WindowManager EnableTiledWindowMargins -bool false || true

defaults write com.apple.finder AppleShowAllFiles -bool true || true
defaults write com.apple.finder FXPreferredViewStyle -string Nlsv || true
defaults write com.apple.screencapture target -string clipboard || true
defaults write com.apple.screencapture target-screenshot -string clipboard || true
defaults -currentHost write com.apple.screensaver idleTime -int 900 || true

killall Dock Finder SystemUIServer 2>/dev/null || true
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u || true
