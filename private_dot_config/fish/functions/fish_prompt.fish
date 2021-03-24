function old_fish_prompt
  test $status -ne 0;
    and set -l colors red
    or set -l colors brblack

  set -l pwd (prompt_pwd)
  set -l base (basename "$pwd")

  set -l expr "s|~|"(fst)"^^"(off)"|g; \
               s|/|"(snd)"/"(off)"|g;  \
               s|"$base"|"(fst)$base(off)" |g"

  echo -n (echo "$pwd" | sed -e $expr)(off)

  for color in $colors
    echo -n (set_color $color)">>>"
  end

  echo -n " "
end
