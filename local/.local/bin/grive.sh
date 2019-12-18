#!/bin/bash
# Google Drive Grive script that syncs your Google Drive folder on change
# This functionality is currently missing in Grive and there are still no
# official Google Drive app for Linux coming from Google.
#
# This script will only detect local changes and trigger a sync. Remote
# changes will go undetected and are probably still best sync on a periodic
# basis via cron.
#
# Kudos to Nestal Wan for writing the excellent Grive software
# Also thanks to Google for lending some free disk space to me
#
# Peter Österberg, 2012

GRIVE_COMMAND_WITH_PATH=/usr/bin/grive   # Path to your grive binary, change to match your system
GDRIVE_PATH=~/Drive/                      # Path to the folder that you want to be synced
GDRIVE_SUBFOLDERS=org
TIMEOUT=60               # Timeout time in seconds, for periodic syncs. Nicely pointed out by ivanmacx

declare -i grive_is_running

#while true
#do
notify-send -u low -t 10 -a Grive "Grive" Grive is syncing
grive_is_running=`pidof grive`
if [[ "$esta_grive_ejecutando" -ne 0 ]]
then
    echo "Grive it's executing, PID: $grive_is_running. Waiting..."
    sleep $TIMEOUT
else
    cd $GDRIVE_PATH && $GRIVE_COMMAND_WITH_PATH -s $GDRIVE_SUBFOLDERS
fi
#done
