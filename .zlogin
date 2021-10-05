# should run only once at login
[[ -z "$SSH_AUTH_SOCK" ]] && eval "$(ssh-agent)"
