echo "Installation Postgresql"
apt-get update > /dev/null 2>&1
apt-get install -y postgresql postgresql-contrib > /dev/null 2>&1
echo "Installation Nginx"
apt-get install -y nginx  2>&1
service nginx enable  
service nginx start
service postgresql start
echo "Création et connexion a la base de données"
su - postgres -c "psql -c \"create database shellbase;\"" > /dev/null 2>&1
su - postgres -c "psql -c \"\\connect shellbase\""  2>&1

echo "Installation PHP"
sudo apt-get install php5-common php5-cli php5-fpm php5-pgsql > /dev/null 2>&1

#echo "création de la table a partir du fichier yaml de facon statique" 
#su - postgres -c "psql -c \"create table shellTab22 (Name varchar(20),first varchar(20), last varchar(20), phone varchar(20), email varchar(20),pdf varchar(20), src varchar(25), url varchar(20) , social varchar(20), github varchar(20), twitter varchar(20), linkedin varchar(20));\""
#su - postgres -c "psql -c \"select * from shellTab22 \""

echo "creation table dynamique a partir du fichier"
FILE=`cat fichier.yaml`
tab=( $( awk -F ":" '{print $1}' fichier.yaml) )
chaine="create table fichiertable ("
i=0
leng=${#tab[@]}

while [ "$i" -lt "$(($leng-1))" ]
do
	chaine="$chaine ${tab[$i]} varchar(50),"
	((i++))
done

chaine="$chaine ${tab[${#tab[@]}-1]} varchar(50));"
# echo "$chaine"
su - postgres -c "psql -c \" $chaine\""
su - postgres -c "psql -c \" select * from fichiertable\""


echo "insertion dans la table"
tab2=( $( awk -F ":" '{print $2}' fichier.yaml) )
chaine2="insert into fichiertable values( '"
k=0
leng2=${#tab2[@]}
while [ "$k" -lt "$(($leng2-1))" ]
do
	chaine2="$chaine2 ${tab2[$k]}' ,'"
	((k++))
done
chaine2="$chaine2 ${tab2[${#tab2[@]}-1]} ');"
#echo "$chaine2"
su - postgres -c "psql -c \" $chaine2\""
su - postgres -c "psql -c \" select * from fichiertable\""
                              

