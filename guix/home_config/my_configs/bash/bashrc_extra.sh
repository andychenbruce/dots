function enter {
    guix shell --check --manifest=$1
}

if [ -v GUIX_ENVIRONMENT ]
then
    LD_LIBRARY_PATH=$LIBRARY_PATH
    export LD_LIBRARY_PATH
fi

