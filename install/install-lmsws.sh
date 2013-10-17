#!/bin/bash --login
if [ $# = 2 ]
 then
    echo "Name: $1\nEmail: $2"
    name=$1
    email=$2
else
    echo "Please enter your name:"
    read name
    echo "Please enter your email:"
    read email
fi
echo "\nWelcome to the installation of LocateMyStickers web service development environment."
echo "\nInstalling libpq-dev..."
sudo apt-get install libpq-dev
./install-rails.sh
echo "\nInstalling git..."
#sudo apt-get install git
#sudo git config --global user.name $name
#sudo git config --global user.email $email
#echo "Installed and configured git for $name $email."
echo "Generating ssh key..."
#sudo ssh-keygen
echo "Please copy/paste the path to the generated id_rsa.pub file?"
#read key_path
#sudo cat $key_path
echo "Copy this key, go to http://gitlab.locatemystickers.com/keys/ and add the ssh key to your account."
echo "Cloning locatemystickers web service from repository..."
#git clone git@ks24070.kimsufi.com:all.git
#cd ./all/web-service
#bundle install
#rake db:migrate
#rake db:populate
#rails s
