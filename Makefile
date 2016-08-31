MAKEFLAGS += --warn-undefined-variables
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := all

vim_dir := $(HOME)/.vim
plug_plugin := $(vim_dir)/autoload/plug.vim
vimrc := $(HOME)/.vimrc
bashrc := $(HOME)/.bashrc
gitconfig := $(HOME)/.gitconfig
ackrc := $(HOME)/.ackrc
tmuxconf := $(HOME)/.tmux.conf

$(plug_plugin):
	@mkdir -p $(dir $@)
	@curl --insecure -sfLo $@ https://raw.github.com/junegunn/vim-plug/master/plug.vim

$(vimrc): $(plug_plugin)
	@ln -nsf $(CURDIR)/vimrc $@

$(bashrc):
	@ln -nsf $(CURDIR)/bashrc $@

$(gitconfig):
	@ln -nsf $(CURDIR)/gitconfig $@

$(ackrc):
	@ln -nsf $(CURDIR)/ackrc $@

$(tmuxconf):
	@ln -nsf $(CURDIR)/tmux.conf $@

$(psqlrc):
	@ln -nsf $(CURDIR)/psqlrc $@

.PHONY: all
all: $(bashrc) $(vimrc) $(gitconfig) $(ackrc) $(tmuxconf) $(psqlrc)
