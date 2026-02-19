# Pipe help output through bat without rewriting the command line
function _help_handler
    set -l cmd (commandline -b)
    if string match -qr -- '(--help|-h)\s*$' "$cmd"
        commandline -r ""
        echo
        # Record in atuin history
        set -l id (atuin history start -- "$cmd" 2>/dev/null)
        eval "$cmd" 2>&1 | bat --plain --language=help
        set -l exit_code $status
        if test -n "$id"
            atuin history end --exit $exit_code "$id" 2>/dev/null
        end
        commandline -f repaint
    else
        commandline -f execute
    end
end

bind \r _help_handler
bind \n _help_handler
