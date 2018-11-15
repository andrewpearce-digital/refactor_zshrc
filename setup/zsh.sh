#!/bin/bash

sudo apt update
sudo apt install -y zsh git-core
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
chsh -s `which zsh`
# sudo shutdown -r 0
