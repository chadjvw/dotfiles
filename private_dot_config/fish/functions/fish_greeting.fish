function fst; set_color addb67; end
function snd; set_color blue; end
function trd; set_color brcyan; end
function dim; set_color brblack; end
function off; set_color normal; end

function fish_greeting
  echo (dim)(uname -mnrs)(off)
end
