Run this to start setup process:

cd ../var/www/;apt-get install software-properties-common python-software-properties -y;add-apt-repository ppa:git-core/ppa -y; apt-get update -y; apt-get install git -y;cd ..;git clone https://github.com/BoredBored/stuff.git;cd stuff;chmod +x *; sh setup.sh;cd "/etc/apache2/sites-available/";vim 000-default.conf;service apache2 reload;
