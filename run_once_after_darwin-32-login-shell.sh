#!/usr/bin/env bash
# fish as the login shell, using the brew-installed binary.
brew=$(command -v brew || echo /opt/homebrew/bin/brew)
[ -n "$brew" ] || { echo "brew not found" >&2; exit 0; }
fish="$("$brew" --prefix)/bin/fish"
[ -x "$fish" ] || { echo "$fish not installed" >&2; exit 0; }
grep -qx "$fish" /etc/shells || echo "$fish" | sudo tee -a /etc/shells >/dev/null || true
[ "$(dscl . -read "/Users/$USER" UserShell | awk '{print $2}')" = "$fish" ] || chsh -s "$fish" || true
