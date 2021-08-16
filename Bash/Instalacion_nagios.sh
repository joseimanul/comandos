sudo apt update -y
sudo apt upgrade -y
sudo apt-get install -y autoconf gcc libc6 make wget unzip apache2 php libapache2-mod-php7.2 libgd-dev
sudo apt upgrade -y
cd /tmp/
wget -O nagioscore.tar.gz https://github.com/NagiosEnterprises/nagioscore/archive/nagios-4.4.5.tar.gz
sudo tar xvzf nagioscore.tar.gz 
cd nagioscore-nagios-4.4.5/
ls -l
sudo ./configure --with-httpd-conf=/etc/apache2/sites-enabled
sudo make all
sudo make install-groups-users
sudo usermod -a -G nagios www-data
sudo make install
sudo make install-daemoninit
sudo make install-commandmode
sudo make install-config
sudo make install-webconf
sudo a2enmod rewrite
sudo a2enmod cgi
sudo ufw allow Apache
sudo ufw reload 
sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin
sudo systemctl restart apache2.service
sudo systemctl status apache2.service
sudo systemctl start nagios.service
sudo systemctl status nagios.service
pwd
cd ..
sudo apt update
sudo apt-get install -y autoconf gcc libc6 libmcrypt-dev make libssl-dev wget bc gawk dc build-essential snmp libnet-snmp-perl gettext -y
sudo apt-get install -y libpqxx3-dev
sudo apt-get install -y libdbi-dev
wget https://github.com/FreeRADIUS/freeradius-client/archive/release_1_1_7.tar.gz
tar xzf release_1_1_7.tar.gz
freeradius-client-release_1_1_7/
sudo ./configure
sudo make
sudo make install
sudo apt-get install -y libldap2-dev
sudo apt-get install -y libmysqlclient-dev
sudo apt-get install -y dnsutils
sudo apt-get install -y smbclient
sudo apt-get install -y qstat -y
sudo apt-get install -y fping
sudo apt-get install -y qmail-tools
cd ..
pwd
wget --no-check-certificate -O nagios-plugins.tar.gz https://github.com/nagios-plugins/nagios-plugins/archive/release-2.2.1.tar.gz
tar zxf nagios-plugins.tar.gz
cd nagios-plugins-release-2.2.1/
sudo ./tools/setup
sudo ./configure
sudo make
sudo make install
sudo systemctl restart apache2.service
sudo systemctl status apache2.service
sudo systemctl start nagios.service
sudo systemctl restart nagios.service
sudo systemctl start nagios.service
sudo systemctl status nagios.service


systemctl (status, start, restart, reload, stop, enable, disable, list-dependencies) nagios.