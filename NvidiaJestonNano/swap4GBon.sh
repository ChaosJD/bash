#! /bin/bash

#   1. Check if you need to increase SWAP with
#   free -m

#   2. Disable ZRAM
sudo systemctl disable nvzramconfig

#   3. 
sudo fallocat -l 4G /mnt/4GB.swap

#   4. allocate the 4GB to swap
sudo chmod 600 /mnt/4GB.swap

#   5. If we have 4 GB available on the card for it to swap back and forth with it will seem like it's like a larger ram space. It'll be slower than ram.
sudo mkswap /mnt/4GB.swap

#   6.
sudo echo "/mnt/4GB.swap swap swap defaults 0 0" >> /etc/fstab

#   7. reboot
sudo reboot

#   8. Check with free -m
