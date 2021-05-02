#!/bin/bash
# add this script to here /etc/ & modify the file permission to u+x

#CREATE rc.local
FILENAME="rc.local";

# CONTENT of file
echo "#!/bin/bash" > $FILENAME;
echo "sleep 10" >> $FILENAME;
echo "sudo /usr/bin/jetson_clocks" >> $FILENAME;
echo "sudo sh -c 'echo 255 > /sys/devices/pwm-fan/target_pwm'" >> $FILENAME;

# MOVING rc.local
sudo mv ./rc.local /etc/;

# CHANGE permission
sudo chmod u+x /etc/rc.local;

# RESTART hint
echo "PLEASE RESTART"
