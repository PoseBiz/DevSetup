for file in /home/vagrant/MoonBox/portal/data/sql/*.sql
do
  echo "importing $file"
  mysql -h10.0.2.2 -uroot pose_development < $file
done