all:
	@ln -nsf $(CURDIR)/gitconfig ~/.gitconfig
	@ln -sfT $(CURDIR)/vim/bundle ~/.vim/bundle
	@ln -nsf $(CURDIR)/vimrc ~/.vimrc
	@ln -nsf $(CURDIR)/tmux.conf ~/.tmux.conf
