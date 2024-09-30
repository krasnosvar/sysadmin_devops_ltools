#!/usr/bin/env bash

#set background as solid color ( not photo)
gsettings set org.gnome.desktop.background picture-uri ''
gsettings set org.gnome.desktop.background picture-uri-dark ''
gsettings reset org.gnome.desktop.background color-shading-type
gsettings set org.gnome.desktop.background primary-color '#df2dd9'


sudo apt update && sudo apt install -y git wget gnupg lsb-release apt-transport-https ca-certificates curl
#ADD repos
# repos vivaldi
# https://help.vivaldi.com/ru/desktop-ru/install-update-ru/manual-setup-vivaldi-linux-repositories/
wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | apt-key add -
sudo add-apt-repository -y 'deb https://repo.vivaldi.com/archive/deb/ stable main'
# brave
# https://brave.com/linux/#release-channel-installation
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|\
sudo tee /etc/apt/sources.list.d/brave-browser-release.list
#waterfox
# https://www.linuxcapable.com/install-waterfox-browser-on-ubuntu-linux/
curl -fsSL https://download.opensuse.org/repositories/home:hawkeye116477:waterfox/xUbuntu_22.04/Release.key |\
 sudo gpg --batch --yes --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_hawkeye116477_waterfox.gpg > /dev/null
echo 'deb http://download.opensuse.org/repositories/home:/hawkeye116477:/waterfox/xUbuntu_22.04/ /' |\
 sudo tee /etc/apt/sources.list.d/home:hawkeye116477:waterfox.list
curl -fsSL https://download.opensuse.org/repositories/home:/hawkeye116477:/waterfox/xUbuntu_20.04/Release.key | sudo gpg --batch --yes --dearmor |\
 sudo tee /etc/apt/trusted.gpg.d/home_hawkeye116477_waterfox.gpg > /dev/null
echo 'deb http://download.opensuse.org/repositories/home:/hawkeye116477:/waterfox/xUbuntu_20.04/ /' |\
 sudo tee /etc/apt/sources.list.d/home:hawkeye116477:waterfox.list
#librewolf
# https://librewolf.net/installation/debian/
distro=$(if echo " una bookworm vanessa focal jammy bullseye vera uma " |\
 grep -q " $(lsb_release -sc) "; then lsb_release -sc; else echo focal; fi)
wget -O- https://deb.librewolf.net/keyring.gpg | sudo gpg --batch --yes --dearmor -o /usr/share/keyrings/librewolf.gpg
sudo tee /etc/apt/sources.list.d/librewolf.sources << EOF > /dev/null
Types: deb
URIs: https://deb.librewolf.net
Suites: $distro
Components: main
Architectures: amd64
Signed-By: /usr/share/keyrings/librewolf.gpg
EOF
#floorp
# https://floorp.app/ru/download/
curl -fsSL https://ppa.ablaze.one/KEY.gpg | sudo gpg --batch --yes --dearmor -o /usr/share/keyrings/Floorp.gpg
sudo curl -sS --compressed -o /etc/apt/sources.list.d/Floorp.list 'https://ppa.ablaze.one/Floorp.list'
# copyq
#clipboard manager, в настройках включить autostart
sudo add-apt-repository ppa:hluk/copyq -y
#docker
# repos for docker
# https://docs.docker.com/engine/install/ubuntu/
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --batch --yes --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
# tofu - free terraform
# https://opentofu.org/docs/intro/install/deb
# gpg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://packagecloud.io/opentofu/tofu/gpgkey | sudo gpg --no-tty --batch --yes --dearmor -o /etc/apt/keyrings/opentofu.gpg
sudo chmod a+r /etc/apt/keyrings/opentofu.gpg
# repo
echo \
  "deb [signed-by=/etc/apt/keyrings/opentofu.gpg] https://packagecloud.io/opentofu/tofu/any/ any main
deb-src [signed-by=/etc/apt/keyrings/opentofu.gpg] https://packagecloud.io/opentofu/tofu/any/ any main" | \
  sudo tee /etc/apt/sources.list.d/opentofu.list > /dev/null
# rancher-desktop
# https://docs.rancherdesktop.io/getting-started/installation/#linux
curl -s https://download.opensuse.org/repositories/isv:/Rancher:/stable/deb/Release.key | gpg --batch --yes --dearmor | sudo dd status=none of=/usr/share/keyrings/isv-rancher-stable-archive-keyring.gpg
echo 'deb [signed-by=/usr/share/keyrings/isv-rancher-stable-archive-keyring.gpg] https://download.opensuse.org/repositories/isv:/Rancher:/stable/deb/ ./' | sudo dd status=none of=/etc/apt/sources.list.d/isv-rancher-stable.list
# VScodium - free vscode
# https://vscodium.com/#install-on-debian-ubuntu-deb-package
# add gpg
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
    | gpg --batch --yes --dearmor \
    | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg
# add repo
echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' \
    | sudo tee /etc/apt/sources.list.d/vscodium.list
# python3.13
#python3.13
sudo add-apt-repository -y ppa:deadsnakes/ppa


sudo apt update -y
sudo apt upgrade -y


#Main OS apps
# git
git config --global user.name "krasnosvar"
git config --global user.email "krasnosvar@gmail.com"
git config --global color.ui auto
# git config --global core.editor "vim"
#
# calibre - for kindle ebook
sudo apt install -y libreoffice audacity transmission sshpass htop expect tree gnome-tweaks calibre
# clear pdf-meta info
# pdftk file.pdf  dump_data |sed -e 's/\(InfoValue:\)\s.*/\1\ /g' | pdftk file.pdf update_info - output file_no_meta.pdf
# https://stackoverflow.com/questions/60738960/remove-pdf-metadata-removing-complete-pdf-metadata
sudo apt install pdftk -y 
#print screen program, добавить на клавишу printScr командой "flameshot gui"
sudo apt install flameshot -y
sudo apt install copyq -y
sudo apt install diodon -y #instead of copyq
#iPhone HEIC lib
sudo apt install heif-gdk-pixbuf -y
# disk utils
# sudo smartctl --xall /dev/nvme0
# sudo nvme smart-log /dev/nvme0
sudo apt install smartmontools nvme-cli  -y
#*.msg converter ( read outlook files from thunderbird)
# https://www.matijs.net/software/msgconv/
# msgconvert YourMessage.msg
sudo apt-get install libemail-outlook-message-perl -y
#flatpak packadge manager
sudo apt install flatpak -y
#Virtualization
#KVM
sudo apt install -y qemu-kvm libvirt-daemon libvirt-clients libvirt-dev bridge-utils virt-manager
echo 'security_driver = "none"' >> /etc/libvirt/qemu.conf
#iostat, pidstat
sudo apt install sysstat -y

#Security
sudo apt install keepassxc -y
sudo ansible -m apt -a deb=https://launchpad.net/veracrypt/trunk/1.26.14/+download/veracrypt-1.26.14-Ubuntu-24.04-amd64.deb localhost

#engineering apps
sudo apt install librecad -y

#for Razer devices ( need for example to turn off RGB-logo-backlight)
# https://openrazer.github.io/#ubuntu
sudo add-apt-repository ppa:openrazer/stable -y
sudo apt install openrazer-meta -y
# https://polychromatic.app/download/ubuntu/
sudo add-apt-repository ppa:polychromatic/stable -y
sudo apt install polychromatic -y


# Browsers
#firefox-based browsers ( waterfox, librefox, Floorp)
#chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
# vivaldi, brave
sudo apt install vivaldi-stable brave-browser waterfox-g-kpe librewolf floorp -y


#nettools
#arp-scan - сканер сети, сканировать локалку - arp-scan --interface=enp0s3 --localnet
#SIP-protocol analyzer- sngrep
#mtr combines the functionality of the traceroute and ping programs in a single network diagnostic tool.
#mtr -i 0.1 yoursite.com
sudo apt install arp-scan sngrep mtr wireshark inetutils-traceroute ldap-utils openssh-server arping httpie -y
#VPN-clients
sudo apt install sshuttle openconnect network-manager-openconnect network-manager-openconnect-gnome openfortivpn -y


#devops-tools ( containers)
# terraform
terraVer=1.9.5; wget "https://releases.hashicorp.com/terraform/1.9.5/terraform_1.9.5_linux_amd64.zip" && unzip terraform_1.9.5_linux_amd64.zip && sudo cp terraform /usr/bin/ && rm -rf terraform_1.9.5_linux_amd64.zip 
# terraform-libvirt
mkdir -p ~/.terraform.d/plugins
wget https://github.com/dmacvicar/terraform-provider-libvirt/releases/download/v0.7.6/terraform-provider-libvirt_0.7.6_linux_amd64.zip
unzip terraform-provider-libvirt_0.7.6_linux_amd64.zip -d ~/.terraform.d/plugins/terraform-provider-libvirt
chmod 0755 ~/.terraform.d/plugins/terraform-provider-libvirt
# install tofu
sudo apt-get install -y tofu
#docker
sudo apt install ca-certificates curl gnupg lsb-release docker-ce docker-ce-cli containerd.io -y
sudo usermod -aG docker den
#docker config
cat <<EOF > /etc/docker/daemon.json
{
  "dns": ["8.8.8.8"]
}
EOF
#kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo mv kubectl /usr/local/bin && sudo chmod +x /usr/local/bin/kubectl
#helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
sudo bash get_helm.sh
#instlal sops for helm-secrets ( with age, installed by apt)
sudo apt install age -y
sudo ansible localhost -m apt -a deb=https://github.com/getsops/sops/releases/download/v3.7.3/sops_3.7.3_amd64.deb
helm plugin install https://github.com/jkroepke/helm-secrets --version v4.4.2
helm plugin install https://github.com/databus23/helm-diff
#helmfile
# https://docs.wakemeops.com/packages/helmfile/
curl -sSL https://raw.githubusercontent.com/upciti/wakemeops/main/assets/install_repository | sudo bash
sudo apt install helmfile=0.163.1-1~ops2deb -y
#terminal multiplexors
sudo apt install python3-newt gawk pastebinit run-one tmux byobu -y
#podman, podman-desktop
# https://flatpak.org/setup/Ubuntu
# https://podman-desktop.io/docs/installation/linux-install
sudo apt install flatpak
sudo apt-get -y install podman
flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install --user flathub io.podman_desktop.PodmanDesktop
# rancher-desktop
sudo apt install rancher-desktop -y
#psql
sudo apt install postgresql-client -y

echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> INSTALL dev apps"
#programming, development
sudo apt install python3-pip python3-venv python3-dev -y
#install go
#https://golang.org/doc/install
sudo apt  install golang-go -y
#for java keytool
sudo apt install openjdk-8-jre-headless -y
# nvim
sudo apt install vim neovim -y
# install codium
sudo apt install -y codium
# # Migrating from VS Code to VS Codium on Linux
# # https://www.roboleary.net/tools/2022/06/13/migrate-from-vscode-to-vscodium-on-linux.html
# #settings with powerline font for zsh
mkdir -p $HOME/.config/VSCodium/User/
cp files/vscode/settings.json $HOME/.config/VSCodium/User/settings.json
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> INSTALL VScodium extensions"
#https://stackoverflow.com/questions/34286515/how-to-install-visual-studio-code-extensions-from-command-line
sudo -u den codium --install-extension ms-python.python
sudo -u den codium --install-extension ms-toolsai.jupyter
sudo -u den codium --install-extension redhat.vscode-yaml
sudo -u den codium --install-extension ms-azuretools.vscode-docker
sudo -u den codium --install-extension ms-kubernetes-tools.vscode-kubernetes-tools
sudo -u den codium --install-extension redhat.java
sudo -u den codium --install-extension eamodio.gitlens
sudo -u den codium --install-extension gitlab.gitlab-workflow
sudo -u den codium --install-extension hashicorp.terraform
sudo -u den codium --install-extension davidanson.vscode-markdownlint
sudo -u den codium --install-extension tomoki1207.pdf



#PIPs
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Install PIPs"
sudo pip3 install ansible yq jq trash-cli jmespath --break-system-packages


# #install DEBs-from-web by ansible
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Install DEBs-from-web by ansible"
sudo ansible -m apt -a deb=https://linux.dropbox.com/ubuntu/pool/main/dropbox_2022.12.05_amd64.deb localhost
sudo ansible -m apt -a deb=https://repo.zabbix.com/zabbix/6.2/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.2-2%2Bubuntu22.04_all.deb localhost
# for keychron keyboard 
sudo ansible -m apt -a deb=https://github.com/the-via/releases/releases/download/v3.0.0/via-3.0.0-linux.deb localhost


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Install SNAPs"
#SNAPs
sudo snap install vlc
sudo snap install code --classic
# copy settings and extensions from codium to vscode
# cp -r $HOME/.config/VSCodium/User/* $HOME/.config/Code/User
# copy extensions
# sudo cp -R ~/.vscode-oss ~/.files/extensions
#
sudo snap install notepadqq
sudo snap install gimp
sudo snap install pycharm-community --classic
sudo snap install postman
sudo snap install telegram-desktop
sudo snap install yq
sudo snap install remmina
sudo snap install dbeaver-ce
sudo snap install nmap
sudo snap install fbreader

echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> INSTALL veracrypt"
sudo apt install libccid pcscd -y
sudo ansible -m apt -a deb=https://launchpad.net/veracrypt/trunk/1.26.14/+download/veracrypt-1.26.14-Ubuntu-24.04-amd64.deb localhost


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> INSTALL vim plugins"
#VIM install plugins
git clone https://github.com/VundleVim/Vundle.vim.git /home/den/.vim/bundle/Vundle.vim
#install vundle plugins via cli
cp files/.vimrc ~/.vimrc
vim +PluginInstall +qall

chown -R den: /home/den


sudo apt autoremove -y
sudo snap refresh && snap list --all |\
 awk '/disabled/{print $1, $3}' | while read name rev; do sudo snap remove "$name" --revision="$rev"; done