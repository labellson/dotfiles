.PHONY: stow unstow

PKG := bash local offlineimap vim ycmd zsh.d config makepkg oh-my-zsh tmux x11 zsh

all:
	@echo Usage: \`make stow\` or \`make unstow\`
	@echo Available packages: \`${PKG}\`

stow:
	@for file in ${PKG}; \
	do \
		stow -S $${file}; \
	done;

	@echo Config stowed

unstow:
	@for file in ${PKG}; \
	do \
		stow -D $${file}; \
	done;

	@echo Config unstowed
