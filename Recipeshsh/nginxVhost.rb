directory '/var/www' do
  recursive true
end

bash 'extract_module' do
  cwd '/var/www'
  code <<-EOH
  wget wget http://wordpress.org/latest.tar.gz
  tar -zxf latest.tar.gz
  EOH
end
 
bash 'extract_module' do
  cwd '/etc/php5/fpm/'
  code <<-EOH
  sed -i '/cgi.fix_pathinfo=1/s/^#//g'  /etc/php5/fpm/php.ini
  sed -i s#cgi.fix_pathinfo=1#cgi.fix_pathinfo=0#g /etc/php5/fpm/php.ini
  EOH
end
file '/var/www/wordpress/wp-config.php' do
 content IO.read('/root/Chef/centos/chefRecipes/Recipeshsh/wordpressdata')
end

file '/etc/nginx/conf.d/blog.opstree.com.conf' do 
  content IO.read('/root/Chef/centos/chefRecipes/Recipeshsh/blog.opstree.com.conf') 
end
 
service ' php5-fpm' do
 action [:stop, :start]
end

service 'nginx' do 
  action [:stop, :start] 
end


 
