# !/bin/bash

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

sudo apt-get update

# install zsh if it is not yet installed
REQUIRED_PKG="zsh"
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
echo Checking for $REQUIRED_PKG: $PKG_OK
if [ "" = "$PKG_OK" ]; then
  echo "No $REQUIRED_PKG. Setting up $REQUIRED_PKG."
  sudo apt-get --yes install $REQUIRED_PKG
fi

parent_path="$(cd -P "$(dirname "${filename}")/..";pwd)"
echo parent_path $parent_path
ZSH_CUSTOM=$HOME/.oh-my-zsh/custom

#install oh-my-zsh
if [ ! -d "${HOME}/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestion.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
fi
cp $parent_path/.zshrc ~/.zshrc

#install power10k
if [ ! -d "${ZSH_CUSTOM}/themes/powerlevel10k" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
fi
cp $parent_path/.p10k.zsh ~/.p10k.zsh
 
# Change default shell to zsh for the current user
sudo usermod --shell $(which zsh) $USER

sudo -u $USER zsh
