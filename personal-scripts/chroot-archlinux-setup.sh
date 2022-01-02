#!/bin/bash

ln -sf /usr/share/zoneinfo/Europe/Dublin /etc/localtime
hwclock --systohc
echo en_US.UTF-8 UTF-8 >> /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 >> /etc/locale.conf
echo Skye >> /etc/hostname
echo "127.0.0.1 Skye" >> /etc/hosts
echo "::1 Skye" >> /etc/hosts
echo "127.0.1.1 Skye.localdomain Skye" >> /etc/hosts

# MAKE SURE TO CHANGE PASSWORD LOL
echo root:passwordhere | chpasswd

pacman -S grub efibootmgr networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools ntfs-3g base-devel reflector snapper bluez bluez-utils cups hplip xdg-utils xdg-user-dirs alsa-utils avahi xdg-user-dirs xdg-utils gvfs nfs-utils inetutils dnsutils pipewire pipewire-alsa pipewire-pulse pipewire-jack bash-completion openssh rsync reflector acpi acpi_call virt-manager qemu qemu-arch-extra edk2-ovmf bridge-utils dnsmasq vde2 openbsd-netcat iptables-nft sof-firmware nss-mdns acpid os-prober terminus-font

# Nvidia Drivers.
pacman -S --noconfirm nvidia-dkms nvidia-utils nvidia-settings

# Only for Asus Laptop.
echo "[g14]" >> /etc/pacman.conf
echo "SigLevel = DatabaseNever Optional TrustAll" >> /etc/pacman.conf
echo "Server = https://arch.asus-linux.org" >> /etc/pacman.conf
pacman -Syyy
pacman -S asusctl linux-g14 linux-g14-headers supergfxctl

# Installing GRUB and making the GRUB config files. 
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

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
systemctl enable power-profiles-daemon.service
systemctl enable supergfxd

# MAKE SURE TO CHANGE PASSWORD DUMMY!!!!
useradd -m oterminal
echo oterminal:passwordhere | chpasswd
usermod -aG libvirt oterminal

echo "oterminal ALL=(ALL) ALL" >> /etc/sudoers.d/ermanno

printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
