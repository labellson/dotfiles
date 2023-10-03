#!/data/data/com.termux/files/usr/bin/env sh
cd ~/storage/shared/my-notes
git pull origin $(git branch --show-current)
