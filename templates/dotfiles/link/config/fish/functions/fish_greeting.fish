function fst; set_color green; end
function snd; set_color blue; end
function trd; set_color cyan; end
function dim; set_color brblack; end
function off; set_color normal; end

function fish_greeting
  echo (dim)(uname -mnprs)(off)
end
