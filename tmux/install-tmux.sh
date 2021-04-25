#!/usr/bin/env bash

VER=${1:-3.1c}
sudo apt update
sudo apt install -y build-essential autoconf automake pkg-config \
    libevent-dev libncurses5-dev bison byacc git
TMP_TMUX='/tmp/tmux'
test -d ${TMP_TMUX} && rm -rf ${TMP_TMUX}
git clone https://github.com/tmux/tmux.git ${TMP_TMUX}
cd ${TMP_TMUX}
git checkout ${VER}
sh autogen.sh
./configure && make
sudo make install
test -f ~/.tmux.conf.bak && exit
mv ~/.tmux.conf ~/.tmux.conf.bak
cat > ~/.tmux.conf << EOF
set -g default-terminal "screen-256color"
set -ga terminal-overrides ",xterm-256color*:Tc"
unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix
set -g status-style 'bg=black fg=#5eacd3'
set -g status-right '%a %Y-%m-%d %H:%M'
bind r source-file ~/.tmux.conf
set -g base-index 1
set -g history-limit 5000
set-window-option -g mode-keys vi
bind-key -T copy-mode-vi v send-keys -X begin-selection
# WSL2 use clip.exe insted of xclip -in -selection clipboard
bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'
set-option -g mouse on
# vim-like pane switching
bind -r k select-pane -U
bind -r j select-pane -D
bind -r h select-pane -L
bind -r l select-pane -R
# git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-resurrect'
run '~/.tmux/plugins/tpm/tpm'
EOF
