function note
    if ! set -q notes_path
        set notes_path ~/projects/notes/
    end

    cp $notes_path/journal/template $notes_path/journal/(date +%F).md
    sed -i '' "s/{date}/"(date +%c)"/" $notes_path/journal/(date +%F).md
end
