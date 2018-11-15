mkcdir ()
{
    mkdir -p -- "$1" &&
      cd -P -- "$1"
}

newnote ()
{
    code ~/workspace/notebooks/"$1" --add ~/workspace/notebooks/
}
