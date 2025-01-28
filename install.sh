#!/bin/bash

# This script is used to install the dependencies and dotfiles from the GitHub repo "RENoMafex/dotfiles"
# It will perform the following steps:
# 1. Updates apt and upgrades the system if the user confirms.
# 2. Installs necessary packages (zsh and git).
# 3. Changes the default shell to zsh.
# 4. Creates a temporary directory and clones the neccesary files into it.
# 5. Asks the which dotfiles should be copied and performs the copy operation.
# 6. Cleans up by removing the temporary directory and unsetting the variables.

# If you don't know how to run this script, please read the README.md file at 
# https://github.com/RENOMafex/dotfiles
# or
# https://github.com/RENOMafex/dotfiles/blob/main/README.md

read -p "Do you want to upgrade the system? (y/N): " response # Ask if the user wants to upgrade the system
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
	sudo apt update && sudo apt upgrade -y # Update and upgrade Machine
elif [[ "$response" =~ ^([mM]afex)$ ]]; then
	sudo apt update && sudo apt upgrade -y # Update and upgrade Machine
	MODE="mafex"
else
	sudo apt update # Only update Machine
fi
sudo apt install -y zsh # Requiement for oh my zsh
sudo apt install -y git # Requiement for oh my zsh
sudo -k chsh -s "$(which zsh)" "$USER" # Change default shell to zsh
mkdir -v tempordir # Create a temporary directory
cd tempordir # Go to the temporary directory
git clone --depth=1 https://github.com/RENoMafex/dotfiles.git
if [[ "$MODE" == "mafex" ]]; then
	for i in copy_p10k copy_zshrc copy_aliases copy_customprompt copy_vimrc install_ohmyzsh install_powerlevel10k; do
		eval $i="y"
	done
else
	read -p "Copy \".p10k.zsh\"? (y/N): " copy_p10k
	read -p "Copy \".zshrc\"? (y/N): " copy_zshrc
	read -p "Copy \".aliases?\" (y/N): " copy_aliases
	read -p "Copy \".customprompt.zsh\"? (y/N): " copy_customprompt
	read -p "Copy \".vimrc\"? (y/N): " copy_vimrc
	read -p "Install \"oh my zsh\"? (y/N): " install_ohmyzsh
	read -p "Install \"Powerlevel10k\"? (y/N): " install_powerlevel10k
fi
if [[ "$copy_p10k" =~ ^([yY][eE][sS]|[yY])$ ]]; then
	cp -fv dotfiles/.p10k.zsh $HOME/.p10k.zsh
fi
if [[ "$copy_zshrc" =~ ^([yY][eE][sS]|[yY])$ ]]; then
	cp -fv dotfiles/.zshrc $HOME/.zshrc
fi
if [[ "$copy_aliases" =~ ^([yY][eE][sS]|[yY])$ ]]; then
	cp -fv dotfiles/.aliases $HOME/.aliases
fi
if [[ "$copy_customprompt" =~ ^([yY][eE][sS]|[yY])$ ]]; then
	cp -fv dotfiles/.customprompt.zsh $HOME/.customprompt.zsh
fi
if [[ "$copy_vimrc" =~ ^([yY][eE][sS]|[yY])$ ]]; then
	cp -fv dotfiles/.vimrc $HOME/.vimrc
fi
if [[ "$install_ohmyzsh" =~ ^([yY][eE][sS]|[yY])$ ]]; then
	sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
fi
if [[ "$install_powerlevel10k" =~ ^([yY][eE][sS]|[yY])$ ]]; then
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
fi
cd .. # Leave temporary directory
rm -rfv tempordir # Remove temporary directory