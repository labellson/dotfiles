#!/bin/bash
set -e

RULE="$(whoami) $(hostname)=(root) NOPASSWD: /usr/bin/prime-switch"
DST="/etc/sudoers.d/$(whoami)-prime-switch"

echo "The following rule will be save in ${DST}:"
echo -e "'${RULE}'\n"

echo "IMPORTANT! Make sure the rule is well formed and you understand what it does"
echo "An ill formed tule can break your system"
read -p "Continue (y/n): " continue

[ ${continue} == 'y' ] && echo ${RULE} | sudo tee ${DST} &&  echo "Success" || echo "Cancelling"
