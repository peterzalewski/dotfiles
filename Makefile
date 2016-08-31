MAKEFLAGS += --warn-undefined-variables
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := all

vim_dir := $(HOME)/.vim
vim_plug := $(vim_dir)/autoload/plug.vim
vimrc := $(HOME)/.vimrc
bashrc := $(HOME)/.bashrc
gitconfig := $(HOME)/.gitconfig
ackrc := $(HOME)/.ackrc
tmuxconf := $(HOME)/.tmux.conf
nvim_dir := $(HOME)/.config/nvim
nviminit := $(nvim_dir)/init.vim
nvim_plug := $(nvim_dir)/autoload/plug.vim

$(vim_plug):
	@mkdir -p $(dir $@)
	@curl --insecure -sfLo $@ https://raw.github.com/junegunn/vim-plug/master/plug.vim

$(vimrc): | $(vim_plug)
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

$(nvim_plug): $(vim_plug)
	@mkdir -p $(dir $@)
	@ln -nsf $< $@

$(nviminit): | $(nvim_plug)
	@mkdir -p $(dir $@)
	@ln -nsf $(CURDIR)/vimrc $@

.PHONY: all
all: $(bashrc) $(vimrc) $(gitconfig) $(ackrc) $(tmuxconf) $(psqlrc) $(nviminit)
