#!/bin/bash
	echo ""
	echo "Updating and upgrading the system via apt"
	echo "Press any key to continue"
	read -n 1 -s
	echo ""
	sudo apt update && sudo apt upgrade -y
	echo ""
	echo "Installing zsh"
	echo "Press any key to continue"
	read -n 1 -s
	echo ""
	sudo apt install -y zsh # Requiement for oh my zsh
	echo ""
	echo "Installing git"
	echo "Press any key to continue"
	read -n 1 -s
	echo ""
	sudo apt install -y git # Requiement for oh my zsh
	echo ""
	echo "Changing shell to zsh"
	echo "Press any key to continue"
	read -n 1 -s
	echo ""
	sudo chsh -s $(which zsh)
	echo ""
	echo "making temporary directory"
	echo "Press any key to continue"
	read -n 1 -s
	echo ""
	mkdir -v tempordir && cd tempordir
	echo ""
	echo "Installing oh my zsh"
	echo "Press any key to continue"
	read -n 1 -s
	echo ""
	sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	echo ""
	echo "Installing powerlevel10k"
	echo "Press any key to continue"
	read -n 1 -s
	echo ""
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
	echo ""
	echo "Downloading dotfiles"
	echo "Press any key to continue"
	read -n 1 -s
	echo ""
	git clone --depth=1 https://github.com/RENoMafex/dotfiles.git
	cd dotfiles
	cp -fv .p10k.zsh $HOME/.p10k.zsh
	cp -fv .zshrc $HOME/.zshrc
	cp -fv .aliases $HOME/.aliases
	cp -fv .customprompt $HOME/.customprompt
	cd ..
	cd ..
	rm -rfv tempordir
	
# To use this script, copy and paste the following command in your terminal
# wget -O /tmp/WIPmakefile.sh https://raw.githubusercontent.com/RENoMafex/dotfiles/master/WIPmakefile.sh && bash /tmp/WIPmakefile.sh


#	##      ####      ##    ##    ######
#	##      ####      ##    ##    #######
#	 ##    ##  ##    ##     ##    ##   ###
#	 ##    ##  ##    ##     ##    ##   ##
#	  ##  ##    ##  ##      ##    #######
#	  ##  ##    ##  ##      ##    #####
#	   ####      ####       ##    ##
#	   ####      ####       ##    ##
#	    ##        ##        ##    ##
