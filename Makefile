all: submodules
	@echo "Linking..."
	@ln -nsf $(CURDIR)/bashrc ~/.bashrc
	@ln -nsf $(CURDIR)/gitconfig ~/.gitconfig
	@ln -nsf $(CURDIR)/vim/bundle ~/.vim
	@ln -nsf $(CURDIR)/vimrc ~/.vimrc
	@ln -nsf $(CURDIR)/tmux.conf ~/.tmux.conf

submodules:
	@echo "Cloning submodules..."
	@git submodule init
	@git submodule update
