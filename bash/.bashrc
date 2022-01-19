# From arch wiki: set fish as a interactive shell only
if [[ $(ps -p $PPID -o 'command=') != "fish" && -z ${BASH_EXECUTION_STRING} && `command -v fish` ]]
then
	exec fish
fi
