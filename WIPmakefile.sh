#!/bin/bash
	sudo apt update #&& sudo apt upgrade -y
	sudo apt install -y zsh # Requiement for oh my zsh
	sudo apt install -y git # Requiement for oh my zsh
	sudo -k chsh -s "$(which zsh)" "$USER" # Change default shell to zsh
	mkdir -v tempordir
	cd tempordir
	git clone --depth=1 https://github.com/RENoMafex/dotfiles.git
	cp -fv dotfiles/.p10k.zsh $HOME/.p10k.zsh
	cp -fv dotfiles/.zshrc $HOME/.zshrc
	cp -fv dotfiles/.aliases $HOME/.aliases
	cp -fv dotfiles/.customprompt.zsh $HOME/.customprompt.zsh
	sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
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
