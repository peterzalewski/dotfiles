all:
	@ln -nsf $(CURDIR)/gitconfig ~/.gitconfig
	@ln -nsf $(CURDIR)/vimrc ~/.vimrc
	@ln -nsf $(CURDIR)/tmux.conf ~/.tmux.conf
