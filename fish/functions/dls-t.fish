function t -d "Create tmp dir and cd in"
    cd (mktemp -d /tmp/$argv.XXXX)
end
