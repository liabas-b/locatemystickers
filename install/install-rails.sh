#!/bin/bash --login
echo "\nExecuting install-rails.sh"
#echo "Installing curl..."
#sudo apt-get install curl
#echo "Installing rvm and ruby..."
#sudo \curl -L https://get.rvm.io | bash -s stable --ruby
source ~/.rvm/scripts/rvm
echo "Installing Ruby dependencies..."
sudo apt-get install ruby1.8-dev ruby1.8 ri1.8 rdoc1.8 irb1.8
sudo apt-get install libreadline-ruby1.8 libruby1.8 libopenssl-ruby
sudo apt-get install libxslt-dev libxml2-dev
echo "Installing Ruby..."
sudo apt-get install ruby
echo "Installing zlib for ruby..."
sudo apt-get install libzlib-ruby
echo "Creating locatemystickers gemset..."
rvm use 1.9.3@locatemystickers --create --default
gem update --system 1.8.24
echo "Installing Rails 3.2.9..."
gem install rails -v 3.2.9
rails -v
echo "Installing postgresql..."
sudo apt-get install postgresql postgresql-client
echo "Installing postgresql gem..."
gem install pg
echo "Installing nokogiri gem..."
sudo gem install nokogiri
echo "Installing graphviz gem..."
sudo aptitude install graphviz