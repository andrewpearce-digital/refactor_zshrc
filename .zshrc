
# if [ -r ~/.zsh_functions ]; then
#     source ~/.zsh_functions
# fi


if [ -n "$(/bin/ls ./.zshrc.d)" ]; then
    for dotfile in ./.zshrc.d/*
    do
        if [ -r "${dotfile}" ]; then
            source "${dotfile}"
        fi
    done
fi

cl
