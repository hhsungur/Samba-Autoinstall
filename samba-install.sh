#!/bin/bash

if [ "$(whoami)" != "root" ]; then
	echo "This script must be run as root"
	exit
fi

if [ -e /etc/samba/smb.conf ]; then
	clear
	while :
	do
		echo "Samba File Server is already installed"
		echo ""
		echo "	1) Add a new user"
		echo "	2) Change user password"
		echo "	3) Remove Samba and Samba's config files"
		echo "	4) Exit"
		read -p "Select an option: " option
		case $option in
			1)
			read -p "Username: " -e USER
			read -p "Password: " -e PASS
			read -p "Home Directory: " -e -i /home/$USER DIR
			cd /etc/samba
			echo "" | tee -a /etc/samba/smb.conf
			echo "[$USER]" | tee -a /etc/samba/smb.conf
			echo "comment = $USER's Samba"
			echo "path = $DIR" | tee -a /etc/samba/smb.conf
			echo "read only = no" | tee -a /etc/samba/smb.conf
			echo "guest on = no" | tee -a /etc/samba/smb.conf
			echo "browseable = yes" | tee -a /etc/samba/smb.conf
			clear
			echo -e "$PASS\\n$PASS" | smbpasswd -a $USER
			if [ -e /etc/init.d/smbd ] || [ -e /etc/init.d/nmbd ] || [ -e /etc/init.d/samba ]; then
					if [ -e /etc/init.d/smbd ]; then
						/etc/init.d/smbd restart
					fi
					if [ -e /etc/init.d/nmbd ]; then
						/etc/init.d/nmbd restart
					fi
					if [ -e /etc/init.d/samba ]; then
					/etc/init.d/samba restart
					fi
				else
					echo "Samba is not installed now."
					echo "Please, Re-run this script."
					exit
			fi
			cd
			clear
			echo "The user has been added."
			exit
			;;
			2)
			clear
			read -p "Please, Enter Samba Username: " -e USER
			echo "Changing $USER's password"
			smbpasswd $USER
			if [ -e /etc/init.d/smbd ] || [ -e /etc/init.d/nmbd ] || [ -e /etc/init.d/samba ]; then
					if [ -e /etc/init.d/smbd ]; then
						/etc/init.d/smbd restart
					fi
					if [ -e /etc/init.d/nmbd ]; then
						/etc/init.d/nmbd restart
					fi
					if [ -e /etc/init.d/samba ]; then
					/etc/init.d/samba restart
					fi
				else
					echo "Samba is not installed now."
					echo "Please, Re-run this script, Remove and reinstall the Samba."
					exit 
			fi
			echo "The password has been changed"
			exit
			;;
			3)
			echo "Samba and Samba's all config files will be deleted."
			read -p "Are you sure? [y/n]: " -e -i n DEL
			if [ "$DEL" = "y" ]; then
				clear
				apt-get remove --purge --yes samba
				apt-get --yes autoremove
				if [ -e /etc/samba/smb.conf ]; then
					rm -rf /etc/samba
				fi
				clear
				echo "The Samba has been removed."
			else
				echo "Closing now"
			fi
			exit
			;;
			4)
			exit
			;;
		esac
	done
else
	clear
	echo "Welcome to Samba File Server AutoInstaller"
	echo ""
	read -p "Please, Enter Username: " -e USER
	read -p "Please, Enter Password: " -e PASS
	read -p "$USER's home directory: " -e -i /home/$USER DIR
		apt-get --yes update
		apt-get --yes install samba
		clear
		if [ -e /etc/samba/smb.conf ]; then
			echo "" | tee -a /etc/samba/smb.conf
			echo "[$USER]" | tee -a /etc/samba/smb.conf
			echo "comment = $USER's Samba"
			echo "path = $DIR" | tee -a /etc/samba/smb.conf
			echo "read only = no" | tee -a /etc/samba/smb.conf
			echo "guest on = no" | tee -a /etc/samba/smb.conf
			echo "browseable = yes" | tee -a /etc/samba/smb.conf
			clear
			echo -e "$PASS\\n$PASS" | smbpasswd -a $USER
			if [ -e /etc/init.d/smbd ] || [ -e /etc/init.d/nmbd ] || [ -e /etc/init.d/samba ]; then
					if [ -e /etc/init.d/smbd ]; then
						/etc/init.d/smbd restart
					fi
					if [ -e /etc/init.d/nmbd ]; then
						/etc/init.d/nmbd restart
					fi
					if [ -e /etc/init.d/samba ]; then
					/etc/init.d/samba restart
					fi
				else
					echo "Samba is not installed now."
					echo "Please, Re-run this script, Remove and reinstall the Samba."
					exit 
			fi
		else
			touch /etc/samba/smb.conf
			echo "" | tee -a /etc/samba/smb.conf
			echo "[$USER]" | tee -a /etc/samba/smb.conf
			echo "comment = $USER's Samba"
			echo "path = $DIR" | tee -a /etc/samba/smb.conf
			echo "read only = no" | tee -a /etc/samba/smb.conf
			echo "guest on = no" | tee -a /etc/samba/smb.conf
			echo "browseable = yes" | tee -a /etc/samba/smb.conf
			clear
			echo -e "$PASS\\n$PASS" | smbpasswd -a $USER
			if [ -e /etc/init.d/smbd ] || [ -e /etc/init.d/nmbd ] || [ -e /etc/init.d/samba ]; then
					if [ -e /etc/init.d/smbd ]; then
						/etc/init.d/smbd restart
					fi
					if [ -e /etc/init.d/nmbd ]; then
						/etc/init.d/nmbd restart
					fi
					if [ -e /etc/init.d/samba ]; then
					/etc/init.d/samba restart
					fi
				else
					echo "Samba is not installed now."
					echo "Please, Re-run this script, Remove and reinstall the Samba."
					exit 
			fi
		fi
	clear
	echo "The Samba has been installed and working now."
fi