#!/bin/bash

FILENAME="secret.flag"
CONTENT="MY_SECRET_FLAG"
OWNER_USER="adam"
TARGET_USER="bushranger.000"
TARGET_GROUP="bushranger.000"

echo "Adding $TARGET_USER to the system" 
sudo useradd "$TARGET_USER"

echo "Changing password" 

sudo echo "$TARGET_USER:$TARGET_USER" | sudo chpasswd


echo "$CONTENT" > "/home/$TARGET_USER/$FILENAME"



echo "setting user to $OWNER_USER and group to $TARGET_GROUP"
sudo chown "$OWNER_USER:$TARGET_GROUP" "/home/$TARGET_USER/$FILENAME"

sudo chmod ugo-rwx "/home/$TARGET_USER/$FILENAME"
sudo chmod u+rw,g+r "/home/$TARGET_USER/$FILENAME"
