#!/usr/bin/env bash
# Safe to rerun; each step is allowed to fail.

# raise open-file limits to the max (perproc can't exceed maxfiles), never lower them
for kv in kern.maxfiles=1310720 kern.maxfilesperproc=1310720; do
  k=${kv%=*} want=${kv#*=}
  [ "$(sysctl -n "$k")" -ge "$want" ] || sudo sysctl "$kv" || true
done
if [ "$(defaults read com.apple.dock mru-spaces 2>/dev/null)" != 0 ]; then
  defaults write com.apple.dock "mru-spaces" -bool false && { killall Dock || true; }
fi
git lfs install || true
