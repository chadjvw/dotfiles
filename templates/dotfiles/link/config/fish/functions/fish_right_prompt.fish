function git::branch_name
  command git symbolic-ref --short HEAD
end

function fish_right_prompt
  set -l code $status
  test $code -ne 0; and echo (dim)"("(trd)"$code"(dim)") "(off)

  if test -n "$SSH_CONNECTION"
     printf (trd)":"(dim)"$HOSTNAME "(off)
   end

  if git rev-parse 2> /dev/null
    printf (snd)(fst)(git::branch_name)(snd)(off)" " 
  end
  printf (dim)(date +%H(fst):(dim)%M(fst):(dim)%S)(off)" "
end
