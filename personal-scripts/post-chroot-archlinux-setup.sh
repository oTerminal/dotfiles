#!/bin/bash

printf "\e[1;32mWelcome to my Arch Install Script!.\e[0m \n"
sleep 1

# Timezone.
printf "\e[1;36mUse your up/down arrow keys to check your timezone and press 'q' when you found your timezone. Make sure you remember it! \e[0mFor example: Europe/Dublin.\e[0m"
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

# Installing necessary packages for btrfs system.
pacman -S grub networkmanager grub-btrfs efibootmgr dialog wpa_supplicant iwd mtools dosfstools ntfs-3g base-devel snapper bluez bluez-utils cups hplip xdg-utils xdg-user-dirs alsa-utils avahi gvfs nfs-utils inetutils dnsutils pipewire pipewire-alsa pipewire-pulse pipewire-jack bash-completion openssh rsync reflector acpi acpi_call virt-manager edk2-ovmf bridge-utils dnsmasq vde2 openbsd-netcat iptables-nft sof-firmware nss-mdns acpid os-prober terminus-font linux-zen linux-zen-headers linux-firmware

# Graphics Drivers.
printf "\e[1;36m What gpu do you have? (amd, nvidia, intel)\e[0m \n"
read gpuname
if [ $gpuname == nvidia ]
then
    pacman -S --noconfirm nvidia nvidia-dkms nvidia-utils nvidia-settings
elif [ $gpuname == amd ]
then
    pacman -S --noconfirm xf86-video-amdgpu
elif [ $gpuname == intel ]
then
    pacman -S --noconfirm mesa xf86-video-intel vulkan-intel
else
    echo "Could not understand the gpu name!"
fi

# Only for Asus Laptop.
#echo "[g14]" >> /etc/pacman.conf
#echo "SigLevel = DatabaseNever Optional TrustAll" >> /etc/pacman.conf
#echo "Server = https://arch.asus-linux.org" >> /etc/pacman.conf
#pacman -Syyy
#pacman -S asusctl linux-g14 linux-g14-headers supergfxctl

# Installing GRUB and making the GRUB config files. 
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
echo "GRUB_DISABLE_OS_PROBER=false" >> /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

#systemctl enable systemd-networkd.service
systemctl enable NetworkManager
systemctl enable bluetooth
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
printf "\e[1;36m Type in a password for your user in the below prompt.\e[0m \n"
passwd $username
usermod -aG libvirt $username

echo "$username ALL=(ALL) ALL" >> /etc/sudoers.d/$username

printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
