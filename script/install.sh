# NGINX:

# 1 -
sudo aptitude install libpcre3 libpcre3-dev libpcrecpp0 libssl-dev zlib1g-dev
cd ./script
tar -zvxf nginx-0.6.35.tar.gz
cd nginx-0.6.35
./configure --sbin-path=/usr/local/sbin --with-http_ssl_module
sudo cp -r ~/web-service/scripts/nginx /etc/init.d/nginx
sudo chmod +x /etc/init.d/nginx

# 2 -
cd ~/web-service
sudo -s
nginx=stable # use nginx=development for latest development version
add-apt-repository ppa:nginx/$nginx
apt-get update 
apt-get install nginx


# Web service:

cd
#ssh-keygen
#cat ./.ssh/id_rsa.pub
# Copy the content of the public rsa key to gitlab account
#git clone git@locatemystickers.com:development/web-service.git
#cd web-service
cp ./script/web-service /etc/nginx/sites-available
ln -s /etc/nginx/sites-available/web-service /etc/nginx/sites-enabled
sudo chmod 777 /etc/nginx/sites-available/web-service
emacs -nw /etc/nginx/sites-available/web-service
# Edit adress of the host in /etc/nginx/sites-available/web-service (replace webservice with labeip)
emacs -nw ./config/puma.rb
# Edit paths from puma configuration to match present config (replace webservice with labeip)

sudo aptitude install ruby libzlib-ruby rdoc irb
cd
wget http://rubyforge.org/frs/download.php/76729/rubygems-1.8.25.tgz
tar -zxf rubygems-1.8.25.tgz
cd rubygems-1.8.25/
sudo ruby setup.rb all

sudo aptitude install curl
curl -L https://get.rvm.io | bash -s stable
rvm install ruby 1.9.3
rvm use 1.9.3
sudo gem install rails --version 3.0.0 --include-dependencies

# ****

cd ~/web-service
bundle install --without development test
bundle --deployment
bundle exec rake db:migrate
bundle exec rake db:populate
bundle exec rake assets:precompile
sudo chmod +x ./script/*
emacs -nw ./script/start
# Edit paths to match present conf
./script/start

