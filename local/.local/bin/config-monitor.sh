#!//bin/sh
## Suboptimal and custom script to modify my monitor settings
##
## USAGE: config-monitor.sh -m MODE [OPTION...]
## Modes:
##   -m MODE                Set mode or secondary screen to configure
## Options:
##   -r                     set secondary screen at --right-of eDP1
##   -l                     set secondary screen at --left-of eDP1
##   -a                     set secondary screen at --above eDP1
##   -b                     set secondary screen at --below eDP1
##   -s                     set secondary screen at --same-as eDP1

set -euo pipefail

help() {
    grep "^##" "$0" | sed -e "s/^...\?//"; exit 0
}

MODE=""
while getopts ":m:rlabs" opt; do
    case ${opt} in
        m) MODE=${OPTARG};;
        r) POSITION="--right-of";;
        l) POSITION="--left-of";;
        a) POSITION="--above";;
        b) POSITION="--below";;
        s) POSITION="--same-as";;
    esac
done

# exit if $MODE is not set
[ ${MODE} ] || help

# default configuration (laptop screen)
if [ ${MODE} = "laptop" ]; then
    xrandr --output eDP1 --auto --primary \
        --output DP1 --off --output DP2 --off \
        --output HDMI1 --off --output HDMI2 --off \
        --output VIRTUAL1 --off

# settings for my home setup (the big monitor is my primary)
elif [ ${MODE} = "home" ]; then
    xrandr --output eDP1 --auto \
        --output DP1 --auto --primary ${POSITION} eDP1

# rest of the configurations (with laptop as principal)
else
    xrandr --output eDP1 --auto --primary \
        --output ${MODE} --auto ${POSITION} eDP1
fi
