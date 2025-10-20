# From arch wiki: set fish as a interactive shell only
# TODO: for some reason I can't run fish in wayland from sddm
# It gets frozen and the compositor never starts
#
# if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z ${BASH_EXECUTION_STRING} && ${SHLVL} == 1 ]]
# then
# 	shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=''
# 	exec fish $LOGIN_OPTION
# fi
