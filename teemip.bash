#!/bin/bash
# This script installs TeemIP

printf "Installing Softwares....\n"
sleep 2s
sudo yum -y install epel-release > /dev/null
if [ $? == 1 ]; then printf "There was an error. 1.\n"; exit; fi
sudo vim /etc/yum.repos.d/epel.repo
sudo yum -y install httpd mariadb mariadb-server unzip wget yum-utils > /dev/null
sudo yum-config-manager --enable remi-php72
if [ $? == 1 ]; then printf "There was an error. 2.\n"; exit; fi
sudo yum -y install php php-mysql php-mycrypt php-xml php-soap php-cli php-ldap php-pdo graphviz php-gd php-mcrypt > /dev/null
if [ $? == 1 ]; then printf "There was an error. 3.\n"; exit; fi

printf "Enabling Services....\n"
sleep 2s
sudo systemctl start httpd
if [ $? == 1 ]; then printf "There was an error. 4.\n"; exit; fi
sudo systemctl start mariadb.service
if [ $? == 1 ]; then printf "There was an error. 5.\n"; exit; fi
sudo systemctl enable httpd > /dev/null
sudo systemctl enable mariadb.service > /dev/null

printf "Running Secure Installation....\n"
sleep 2s
sudo mysql_secure_installation
if [ $? == 1 ]; then printf "There was an error. 6.\n"; exit; fi

printf "Creating Database....\n"
sleep 2s
mysql -u root -p

printf "Modifiying PHP....\n"
sleep 2s
sudo printf "\n%s\n" "max_allowed_packed=32MB" >> /etc/my.cnf

printf "Restarting Services....\n"
sleep 2s
if [ $? == 1 ]; then printf "There was an error. 7.\n"; exit; fi
sudo systemctl restart httpd
if [ $? == 1 ]; then printf "There was an error. 8.\n"; exit; fi
sudo systemctl restart mariadb.service
if [ $? == 1 ]; then printf "There was an error. 9.\n"; exit; fi

printf "Installing TeemIP....\n"
sleep 2s
sudo wget https://sourceforge.net/projects/teemip/files/teemip%20-%20a%20standalone%20application/2.3.0/TeemIp-2.3.0-1808.zip
if [ $? == 1 ]; then printf "There was an error. 10.\n"; exit; fi
sudo mkdir /var/www/html/teemip
if [ $? == 1 ]; then printf "There was an error. 11.\n"; exit; fi
sudo unzip 'TeemIP-2.3.0-1808.zip' -d /var/www/html/teemip/
if [ $? == 1 ]; then printf "There was an error. 12.\n"; exit; fi
sudo chown -R apache:apache /var/www/html/teemip/
if [ $? == 1 ]; then printf "There was an error. 13.\n"; exit; fi

printf "Done!!!!\n\n"
sleep 2s
exit