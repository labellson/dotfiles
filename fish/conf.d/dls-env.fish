# load variables in ~/.dotenv
set -l dotenvdir "$HOME/.dotenv"
if test -e $dotenvdir
    for envfile in (ls $dotenvdir)
        type -q dotenv && dotenv $dotenvdir/$envfile
    end
end
