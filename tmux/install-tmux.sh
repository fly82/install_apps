#!/usr/bin/env bash

VER=${1:-3.1c}
sudo apt update
sudo apt install -y build-essential autoconf automake pkg-config \
    libevent-dev libncurses5-dev bison byacc git
test -d /tmp/tmux && rm -rf /tmp/tmux
git clone https://github.com/tmux/tmux.git /tmp/tmux
cd /tmp/tmux
git checkout $VER
sh autogen.sh
./configure && make
sudo make install
test -f ~/.tmux.conf.bak && exit
mv ~/.tmux.conf ~/.tmux.conf.bak
cat > ~/.tmux.conf << EOL
set -ga terminal-overrides ",xterm-256color*:Tc"

unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix
set -g status-style 'bg=#333333 fg=#5eacd3'

bind r source-file ~/.tmux.conf
set -g base-index 1

set-window-option -g mode-keys vi
bind-key -T copy-mode-vi v send-keys -X begin-selection
bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'

# vim-like pane switching
bind -r k select-pane -U
bind -r j select-pane -D
bind -r h select-pane -L
bind -r l select-pane -R
EOL
