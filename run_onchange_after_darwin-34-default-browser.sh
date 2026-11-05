#!/usr/bin/env bash
# defaultbrowser pops a confirm dialog, so only run it when the https handler differs.
command -v defaultbrowser >/dev/null || exit 0
current=$(defaults read com.apple.LaunchServices/com.apple.launchservices.secure LSHandlers 2>/dev/null |
  awk '/LSHandlerRoleAll = /{v=$3; gsub(/[";]/,"",v)} /LSHandlerURLScheme = https;/{print v}')
[ "$current" = net.waterfox.waterfox ] || defaultbrowser waterfox || true
