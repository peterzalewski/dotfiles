all: submodules
	@echo "Linking..."
	@ln -nsf $(CURDIR)/bashrc ~/.bashrc
	@ln -nsf $(CURDIR)/gitconfig ~/.gitconfig
	@ln -nsf $(CURDIR)/vim/bundle ~/.vim/bundle
	@ln -nsf $(CURDIR)/vimrc ~/.vimrc
	@ln -nsf $(CURDIR)/tmux.conf ~/.tmux.conf
	@ln -nsf $(CURDIR)/ackrc ~/.ackrc

submodules:
	@echo "Cloning submodules..."
	@git submodule init
	@git submodule update
