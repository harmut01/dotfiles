function jr
    if ! set -q notes_path
        set notes_path ~/projects/notes
    end

    if test -f ~/projects/notes/(date +%F).md
        note
    end

    nvim -O $notes_path/plan.md $notes_path/journal/(date +%F).md $argv
end
