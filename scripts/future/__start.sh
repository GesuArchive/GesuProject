
clear
echo '----------------------------------------'

echo -e '\nInstalling dependencies...'
sudo apt update
sudo apt dist-upgrade -y
sudo apt autoremove -y
sudo dpkg --add-architecture i386

echo -e '\nInstalling Python...'
sudo apt install -y python3

echo -e '\nDeleting unnecessary packages...'
sudo apt autoremove -y && sudo apt-get autoclean -y

echo -e '\nStarting Python script...'
python3 -m _download_byond_ver.py
