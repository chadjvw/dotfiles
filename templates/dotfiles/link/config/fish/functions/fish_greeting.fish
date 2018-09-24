function fst; set_color -o yellow; end
function snd; set_color -o blue; end
function trd; set_color -o magenta; end
function dim; set_color    brblack; end
function off; set_color normal; end

function fish_greeting
  echo (dim)(uname -mnprs)(off)
end
