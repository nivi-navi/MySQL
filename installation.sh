#!/bin/bash
data ()
{
read -p "Enter the service you want to be installed:" service
status=$(systemctl is-active $service)
if [ $status == "inactive" ]
then
sudo dnf install $service -y
sudo systemctl enable --now $service
sudo firewall-cmd --add-port=80/tcp --permanent
sudo firewall-cmd --reload
sudo setenforce 0
sudo getenforce
echo "Done"
sudo sed -i s/local/"all granted"/g /etc/httpd/conf.d/phpMyAdmin.conf
#sudo systemctl restart mysqld.service
sudo systemctl restart httpd.service

fi
}
data "httpd" 
data "mysql-server" 
data "phpmyadmin"