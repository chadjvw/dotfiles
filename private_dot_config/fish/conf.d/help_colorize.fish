# Pipe help output through bat without rewriting the command line
function _help_handler
    set -l cmd (commandline -b)
    if string match -qr -- '(--help|-h)\s*$' "$cmd"
        # Tools where -h is not help (e.g. ln: no-deref, ls/du/df: human-readable)
        set -l no_h_help ln ls du df cut cp mv chmod chown tar head tail sort curl
        set -l prog (string match -r -- '^\s*(\S+)' "$cmd")[2]
        if string match -qr -- '-h\s*$' "$cmd"; and contains -- $prog $no_h_help
            commandline -f execute
            return
        end
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
