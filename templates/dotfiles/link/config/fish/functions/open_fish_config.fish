function open_fish_config
  and set FISH_CONFIG_URL (find ~/.cache/fish -name "*web_config*.html" -exec grep href '{}' \; | sed -E "s/(  <p><a href=\")(http:\/\/localhost:[0-9]{4}\/[a-zA-Z0-9]+\/)(.*)/\2/g")
  and rundll32.exe url.dll,FileProtocolHandler $FISH_CONFIG_URL
end
