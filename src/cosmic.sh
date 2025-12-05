#!/bin/bash

echo "installing cosmic desktop environment"
paru -Sy --needed --noconfirm - < ~/arch-setup/apps/cosmic.list

echo "enabling cosmic services"
sudo systemctl enable cosmic-greeter.service
sudo systemctl start cosmic-greeter.service

echo "enabling cosmic clipboard control"
echo 'export COSMIC_DATA_CONTROL_ENABLED=1' | sudo tee /etc/profile.d/data_control_cosmic.sh > /dev/null
# to disable, run: sudo rm -f /etc/profile.d/data_control_cosmic.sh
