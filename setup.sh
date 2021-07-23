sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --setopt max_parallel_downloads=16 --setopt fastestmirror=1 --save

echo "Upgrading system..."
sudo dnf upgrade -y

echo "Enabling RPM-fusion..."
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

#Docker
echo "Clean legacy docker packages..."
sudo dnf remove -y docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine
                  

#sudo dnf config-manager \
#    --add-repo \
#    https://download.docker.com/linux/fedora/docker-ce.repo
   
# dnf list docker-ce  --showduplicates | sort -r

#sudo dnf -y install docker-ce docker-ce-cli containerd.io
#sudo usermod -aG docker $USER # May need to relogin for group change to take effect
#echo "May need to relogin for group (docker) change to take effect"
#sudo systemctl enable --now docker.service containerd.service
#echo "Docker installation completed"

#Utils
echo "Installing utility packages..."

sudo dnf install -y fish zsh autojump jq vim neofetch htop ripgrep dnfdragora gnome-tweaks xeyes s-tui

#Zsh setup
echo "Setting up zsh..."
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
omz theme use agnoster
sudo usermod -s $(which zsh) sadiq

# Setup Scala environment
echo "Setting up Scala environment..."
curl -fLo cs https://git.io/coursier-cli-"$(uname | tr LD ld)"
chmod +x cs
./cs setup --yes --jvm graalvm-ce-java8 --apps ammonite,bloop,cs,giter8,sbt,scala,scalafmt
rm -f ./cs


#Setup GitHub
#sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
#sudo dnf install -y gh

#Setup Entertainment

echo "Installing multimedia apps..."
sudo dnf install -y ffmpeg vlc mpv gimp


#Setup Samba
echo "Setting up samba..."
sudo dnf install -y samba
sudo systemctl enable smb --now
firewall-cmd --get-active-zones
sudo firewall-cmd --permanent --zone=FedoraWorkstation --add-service=samba
sudo firewall-cmd --reload

sudo smbpasswd -a sadiq
mkdir /home/sadiq/share
sudo semanage fcontext --add --type "samba_share_t" ~/share
sudo restorecon -R ~/share

sudo tee -a /etc/samba/smb.conf > /dev/null <<EOT
[share]
        comment = My Share
        path = /home/sadiq/share
        writeable = yes
        browseable = yes
        public = yes
        create mask = 0644
        directory mask = 0755
        write list = user
EOT

#SSH enable
echo "Enabling sshd..."
sudo systemctl enable --now sshd

