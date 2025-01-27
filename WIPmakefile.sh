#!/bin/sh
	sudo apt update
	sudo apt install -y zsh # Requiement for oh my zsh
	sudo apt install -y git # Requiement for oh my zsh
	sudo chsh -s $(which zsh)
	mkdir tempordir
	cd tempordir
	sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
	git clone --depth=1 https://github.com/RENoMafex/dotfiles.git
	cd dotfiles
	cp -f .p10k.zsh ~/.p10k.zsh
	cp -f .zshrc ~/.zshrc
	cp -f .aliases ~/.aliases
	cp -f .customprompt ~/.customprompt
	cd ..
	cd ..
	rm -rf tempordir
	
# To use this script, copy and paste the following command in your terminal
#

#	##      ####      ##    ##    ######
#	##      ####      ##    ##    #######
#	 ##    ##  ##    ##     ##    ##   ###
#	 ##    ##  ##    ##     ##    ##   ##
#	  ##  ##    ##  ##      ##    #######
#	  ##  ##    ##  ##      ##    #####
#	   ####      ####       ##    ##
#	   ####      ####       ##    ##
#	    ##        ##        ##    ##
