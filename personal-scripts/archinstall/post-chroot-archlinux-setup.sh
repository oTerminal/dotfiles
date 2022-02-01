#!/bin/bash

printf "\e[1;32mWelcome to my Arch Install Script!.\e[0m \n"
sleep 1

# Timezone.
printf "\e[1;36mUse your up/down arrow keys to check your timezone and press 'q' when you found your timezone. Make sure you remember it! \e[0mFor example: Europe/Dublin.\e[0m \n"
sleep 5
timedatectl list-timezones | less

echo What is your timezone? \(Case sensitive\)
read timezone
ln -sf /usr/share/zoneinfo/$timezone /etc/localtime
hwclock --systohc

# Locales.
echo en_US.UTF-8 UTF-8 >> /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 >> /etc/locale.conf

# Hostname and Hosts file.
printf "\e[1;36mWhat do you want your hostname to be? (Not the username and capital letters can be used.)\e[0m \n"
read hostname
echo $hostname >> /etc/hostname
echo "127.0.0.1 $hostname" >> /etc/hosts
echo "::1 $hostname" >> /etc/hosts
echo "127.0.1.1 $hostname.localdomain $hostname" >> /etc/hosts

# Changing root password.
printf "\e[1;36mType in your root password in the below prompt.\e[0m \n"
passwd root

# Installing necessary packages.
printf "\e[1;36mInstalling only necessary packages to give you a minimal and fast experience!\e[0m \n"
pacman -S reflector
printf "\e[1;36mEnter your country to sync arch linux mirrors.\e[0m \n"
read country
reflector -c $country -a 8 --sort rate --save /etc/pacman.d/mirrorlist
sleep 1
pacman -S grub grub-btrfs btrfs-progs efibootmgr dialog wpa_supplicant iwd mtools dosfstools ntfs-3g base-devel snapper bluez bluez-utils cups hplip xdg-utils xdg-user-dirs alsa-utils avahi gvfs nfs-utils inetutils dnsutils pipewire pipewire-alsa pipewire-pulse pipewire-jack bash-completion openssh rsync reflector acpi acpi_call bridge-utils dnsmasq vde2 openbsd-netcat iptables-nft sof-firmware nss-mdns acpid os-prober linux-zen linux-zen-headers linux-firmware firefox archlinux-keyring

printf "\e[1;36mWhat cpu do you have? (amd, intel)\e[0m \n"
read cpuname
if [ $cpuname == amd ]
then
    pacman -S --noconfirm mesa amd-ucode
elif [ $cpuname == intel ]
then
    pacman -S --noconfirm mesa intel-ucode
else
    echo "Could not understand the cpu name!"
fi

# Graphics Drivers.
printf "\e[1;36mWhat gpu do you have? (amd, nvidia, intel)\e[0m \n"
read gpuname
if [ $gpuname == nvidia ]
then
    pacman -S --noconfirm nvidia nvidia-dkms nvidia-utils nvidia-settings
elif [ $gpuname == amd ]
then
    pacman -S --noconfirm xf86-video-amdgpu
elif [ $gpuname == intel ]
then
    pacman -S --noconfirm xf86-video-intel vulkan-intel
else
    echo "Could not understand the gpu name!"
fi

# Only for Asus Laptop.
#echo "[g14]" >> /etc/pacman.conf
#echo "SigLevel = DatabaseNever Optional TrustAll" >> /etc/pacman.conf
#echo "Server = https://arch.asus-linux.org" >> /etc/pacman.conf
#pacman -Syyy
#pacman -S asusctl linux-g14 linux-g14-headers supergfxctl

# Setting up systemd-networkd
printf "\e[1;36mInternet Setup with systemd-networkd\e[0m \n"
sleep 2
wiredinterface=$(ip l | sed -nr "s/^[0-9]*: //p" | sed -nr "s/:.*$//p" | grep -o -E "\be\w+")
echo "[Match]" >> /etc/systemd/network/20-wired.network
echo Name=$wiredinterface >> /etc/systemd/network/20-wired.network
echo "[Network]" >> /etc/systemd/network/20-wired.network
echo "DHCP=yes" >> /etc/systemd/network/20-wired.network

wirelessinterface=$(ip l | sed -nr "s/^[0-9]*: //p" | sed -nr "s/:.*$//p" | grep -o -E "\bw\w+")
echo "[Match]" >> /etc/systemd/network/25-wireless.network
echo "Name=$wirelessinterface" >> /etc/systemd/network/25-wireless.network
echo "[Network]" >> /etc/systemd/network/25-wireless.network
echo "DHCP=yes" >> /etc/systemd/network/25-wireless.network
echo "IgnoreCarrierLoss=3s" >> /etc/systemd/network/25-wireless.network
printf "\e[1;36mInternet has been setup!\e[0m \n"

# Installing GRUB and making the GRUB config files. 
printf "\e[1;36mInstalling GRUB!\e[0m \n"
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
echo "GRUB_DISABLE_OS_PROBER=false" >> /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

printf "\e[1;36mEnabling Services!\e[0m \n"
sleep 1
systemctl enable systemd-networkd.service
systemctl enable bluetooth
systemctl enable iwd
systemctl enable systemd-resolved
systemctl enable cups.service
systemctl enable sshd
systemctl enable avahi-daemon
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable libvirtd
systemctl enable acpid

# Services for the packages installed for Asus Laptop.
#systemctl enable power-profiles-daemon.service
#systemctl enable supergfxd

# Creating user.
printf "\e[1;36mWhat do you want your user's name to be? No spaces or capital letters allowed in the username.\e[0m \n"
read username
useradd -m $username
printf "\e[1;36mType in a password for your user in the below prompt.\e[0m \n"
passwd $username

echo "$username ALL=(ALL) ALL" >> /etc/sudoers.d/$username

sleep 1
printf "\e[1;36mIf you use WiFi, after you have rebooted into your new Arch Linux install, type in \"iwctl\" and do these steps\e[0m \n"
wirelessinterface=$(ip l | sed -nr "s/^[0-9]*: //p" | sed -nr "s/:.*$//p" | grep -o -E "\bw\w+")
sleep 2
printf "\e[1;36m\"station $wirelessinterface scan\"\e[0m \n"
sleep 3
printf "\e[1;36m\"station $wirelessinterface get-networks\"\e[0m \n"
sleep 3
printf "\e[1;36m\"station $wirelessinterface connect yourwifinamehere and you can type in your password when it asks you for it and type exit after you have typed it!\"\e[0m \n"
sleep 3
printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m \n"
sleep 1
