echo "Installation Postgresql"
apt-get update > /dev/null 2>&1
apt-get install -y postgresql postgresql-contrib > /dev/null 2>&1
add-apt-repository ppa:nginx/stable > /dev/null 2>&1
apt-get install -y nginx
systemctl enable nginx 
systemctl start nginx

echo "connexion  a la base de données"

su - postgres > /dev/null 2>&1
psql
CREATE DATABASE challenge;
\connect challenge 
while read line; do 
echo -e "$line\n"; done < info.yaml

