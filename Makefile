DOTFILES_ROOT := $(shell pwd)

all: bash zsh brew bin git vim tmux editorconfig msmtp urlview defaults rust
.PHONY: bash zsh brew bin git vim tmux editorconfig msmtp mutt urlview defaults rust

brew:
	ln -fs $(DOTFILES_ROOT)/brew/Brewfile ${HOME}/.Brewfile
	brew bundle --global

bin:
	[ ! -h ${HOME}/.bin ] && ln -fs $(DOTFILES_ROOT)/bin ${HOME}/.bin || true

git:
	ln -fs $(DOTFILES_ROOT)/git/.gitconfig ${HOME}/.gitconfig
	ln -fs $(DOTFILES_ROOT)/git/.gitignore ${HOME}/.gitignore

vim:
	$(call install-if-missing, "vim")
	[ ! -L ${HOME}/.vim ] && ln -Ffs $(DOTFILES_ROOT)/vim/ ${HOME}/.vim || true
	$(DOTFILES_ROOT)/vim/script/update_pack ttaylorr
	ln -fs $(DOTFILES_ROOT)/vim/.vimrc ${HOME}/.vimrc

editorconfig:
	ln -fs $(DOTFILES_ROOT)/editorconfig/.editorconfig ${HOME}/.editorconfig

defaults:
	defaults write -g KeyRepeat -int 1
	defaults write -g InitialKeyRepeat -int 10
	defaults write -g ApplePressAndHoldEnabled -bool false

urlview:
	ln -fs $(DOTFILES_ROOT)/urlview/.urlview ${HOME}/.urlview

zsh:
	$(call install-if-missing, "zsh")
	ln -fs $(DOTFILES_ROOT)/zsh/.zshrc ${HOME}/.zshrc

bash:
	ln -fs $(DOTFILES_ROOT)/bash/.bashrc ${HOME}/.bashrc

define install-if-missing
	@brew list $1 > /dev/null 2>&1 || brew install $1
endef
