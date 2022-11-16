#!/bin/bash

# Load all the environment variables
source /setup/.env

POTOS_VERSION="${POTOS_CLIENT_NAME} (${POTOS_CLIENT_SHORTNAME})"

if [[ -f /setup/potos-version ]]; then
  POTOS_VERSION="$(</setup/potos-version)"
fi

yad --fullscreen --title '${POTOS_CLIENT_NAME} Setup' \
  --borders 20 --align center --button OK --image-on-top \
  --image=/potos-setup/potos.png \
  --text \
"Welcome to the last step of the Potos installation

Client: ${POTOS_VERSION}

Environment Variables:
POTOS_SPECS_REPOSITORY: ${POTOS_SPECS_REPOSITORY}
POTOS_ADJOIN: ${POTOS_ADJOIN}
POTOS_ENV: ${POTOS_ENV}
POTOS_FULL_DISK_ENCRYPTION_INITIAL_PASSWORD: ${POTOS_FULL_DISK_ENCRYPTION_INITIAL_PASSWORD}
POTOS_INITIAL_HOSTNAME: ${POTOS_INITIAL_HOSTNAME}
POTOS_CLIENT_NAME: ${POTOS_CLIENT_NAME}
POTOS_CLIENT_SHORTNAME: ${POTOS_CLIENT_SHORTNAME}
"

#sudo systemctl restart gdm.service

################################################################################
# Finalize the installation
################################################################################

sed -ie 's/GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/' /etc/default/grub
/usr/sbin/update-grub

cat > /var/lib/AccountsService/users/admin <<EOF
[User]
SystemAccount=true
EOF

echo "# Cleaning up ... please wait"

rm -f /etc/sudoers.d/01_gnome-initial-setup
apt purge -y gnome-initial-setup
userdel -rf gnome-initial-setup

rm -rf /setup

sleep 5s
systemctl reboot

# vim: tabstop=2 shiftwidth=2 expandtab softtabstop=2

