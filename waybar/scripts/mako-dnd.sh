#!/usr/bin/env sh

get_state() {
    makoctl mode | grep -q "dnd" && echo "dnd-none" || echo "none"
}

toggle_state() {
    case "$(get_state)" in
        dnd-none)
            makoctl mode -r dnd
            ;;
        none)
            makoctl mode -a dnd
            ;;
    esac
}

if [ "${1}" = "toggle" ]; then
    toggle_state
fi

jq -n --unbuffered --compact-output --arg icon "$(get_state)" '{"alt": $icon}'
