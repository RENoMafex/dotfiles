#!/bin/bajsh
	echo "Updating and upgrading the system via apt"
	echo "Press any key to continue"
	read -n 1 -s
	sudo apt update && sudo apt upgrade -y
	echo "Installing zsh"
	echo "Press any key to continue"
	read -n 1 -s
	sudo apt install -y zsh # Requiement for oh my zsh
	echo "Installing git"
	echo "Press any key to continue"
	read -n 1 -s
	sudo apt install -y git # Requiement for oh my zsh
	echo "Changing shell to zsh"
	echo "Press any key to continue"
	read -n 1 -s
	sudo chsh -s $(which zsh)
	echo "making temporary directory"
	echo "Press any key to continue"
	read -n 1 -s
	mkdir tempordir && cd tempordir
	echo "Installing oh my zsh"
	echo "Press any key to continue"
	read -n 1 -s
	sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	echo "Installing powerlevel10k"
	echo "Press any key to continue"
	read -n 1 -s
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
	echo "Downloading dotfiles"
	echo "Press any key to continue"
	read -n 1 -s
	git clone --depth=1 https://github.com/RENoMafex/dotfiles.git
	cd dotfiles
	cp -fv .p10k.zsh ~/.p10k.zsh
	cp -fv .zshrc ~/.zshrc
	cp -fv .aliases ~/.aliases
	cp -fv .customprompt ~/.customprompt
	cd ..
	cd ..
	rm -rfv tempordir
	
# To use this script, copy and paste the following command in your terminal
# wget -O - https://raw.githubusercontent.com/RENoMafex/dotfiles/master/WIPmakefile.sh | sh

#	##      ####      ##    ##    ######
#	##      ####      ##    ##    #######
#	 ##    ##  ##    ##     ##    ##   ###
#	 ##    ##  ##    ##     ##    ##   ##
#	  ##  ##    ##  ##      ##    #######
#	  ##  ##    ##  ##      ##    #####
#	   ####      ####       ##    ##
#	   ####      ####       ##    ##
#	    ##        ##        ##    ##
