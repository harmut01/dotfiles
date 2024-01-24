if status is-interactive
    # Commands to run in interactive sessions can go here
    if test -d ~/projects
        set -U PROJECTS ~/projects
    else
        set -U PROJECTS /workspaces
    end
end
