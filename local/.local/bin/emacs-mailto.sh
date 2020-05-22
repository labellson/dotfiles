#!/bin/bash
emacsclient -e "(set-up-i3)" -c --eval "(browse-url-mail \"$@\")"
