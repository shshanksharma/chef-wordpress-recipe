bash 'install_something' do
  user 'root'
  code <<-EOH
  mysql -u root -e "CREATE DATABASE wordpress;"
  mysql -u root -e "CREATE USER wordpressuser@localhost IDENTIFIED BY 'password';"
  mysql -u root -e "GRANT ALL PRIVILEGES ON wordpress.* TO wordpressuser@localhost;"
  mysql -u root -e "FLUSH PRIVILEGES;"
  EOH
end
