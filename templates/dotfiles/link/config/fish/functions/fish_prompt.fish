function fish_prompt
  # wakatime for fish
  #
  # Add this to the fish_prompt function in
  # ~/.config/fish/functions/fish_prompt.fish
  # (or if it doesn't exist, create it).


  # We've also included an example of how
  # to determine the current project from the pwd.
  # It'll only work without alterations if
  # you happen to keep all your projects in
  # ~/Sites/ on a Mac, but it's easy to modify

  set -l project

  if echo (pwd) | grep -qEi "^/mnt/c/git"
      set  project (echo (pwd) | sed "s#^/mnt/c/git/\\([^/]*\\).*#\\1#")
  else
      set  project "Terminal"
  end

  wakatime --write --plugin "fish-wakatime/0.0.1" --entity-type app --project "$project" --entity (echo $history[1] | cut -d ' ' -f1) 2>&1 > /dev/null &

  test $status -ne 0;
    and set -l colors 600 900 c00
    or set -l colors 333 666 aaa

  set -l pwd (prompt_pwd)
  set -l base (basename "$pwd")

  set -l expr "s|~|"(fst)"^^"(off)"|g; \
               s|/|"(snd)"/"(off)"|g;  \
               s|"$base"|"(fst)$base(off)" |g"

  echo -n (echo "$pwd" | sed -e $expr)(off)

  for color in $colors
    echo -n (set_color $color)">"
  end

  echo -n " "
end