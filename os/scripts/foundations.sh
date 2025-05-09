#!/bin/bash

set -x

FILENAME="secret.flag"
CONTENT="MY_SECRET_FLAG"
OWNER_USER="adam"
TARGET_USER="bushranger.000"
TARGET_GROUP="bushranger.000"


echo "removing $TARGET_USER from system" 
sudo userdel --remove $TARGET_USER 

echo "Adding $TARGET_USER to the system" 
sudo useradd "$TARGET_USER"

echo "Changing password" 

sudo echo "$TARGET_USER:$TARGET_USER" | sudo chpasswd

echo "setting user to $OWNER_USER and group to $TARGET_GROUP"
sudo chown "$OWNER_USER:$TARGET_GROUP" "/home/$TARGET_USER/"

sudo chmod ugo-rwx "/home/$TARGET_USER/"
sudo chmod u+rwx,g+rx "/home/$TARGET_USER/"

touch "/home/$TARGET_USER/$FILENAME"
sudo chown "$OWNER_USER:$TARGET_GROUP" "/home/$TARGET_USER/$FILENAME"
sudo chmod u+rw,g+r,o-rwx "/home/$TARGET_USER/$FILENAME"
echo "$CONTENT" > "/home/$TARGET_USER/$FILENAME"






