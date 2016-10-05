#
# Cookbook Name:: s
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
apt_update 'all platforms' do
  action :update
end

package 'nginx' do
 action :install
end

service 'nginx' do
 action [ :enable, :start ]
end

package 'mysql-server' do
 action :install
end

package ['php5-fpm','php5-mysql'] do
action :install
end


directory "#{node['nginx']['webroot']}" do
  recursive true
end


#bash 'mycommand' do
#  cwd "#{node['nginx']['webroot']}"
#  environment 'PATH' => "/root/vagrant/cookbooks/s/files/default/wordpresstar.sh:#{ENV['PATH']}"
#  end

execute "mycommand" do
 command "sh root/vagrant/cookbooks/s/files/default/wordpresstar.sh"
end


execute "edit-fpm" do
  command "sh /root/vagrant/cookbooks/s/files/default/php.sh"
end

execute "mysql" do
 command "sh /root/vagrant/cookbooks/s/files/default/mysql.sh"
end

#bash 'extract_module' do
#  cwd '/etc/php5/fpm/'
#  code <<-EOH
#  sed -i '/cgi.fix_pathinfo=1/s/^#//g'  /etc/php5/fpm/php.ini
#  sed -i s#cgi.fix_pathinfo=1#cgi.fix_pathinfo=0#g /etc/php5/fpm/php.ini
#  EOH
#end

template "/etc/nginx/conf.d/#{node['nginx']['conffile']}" do
  source 'chefmanagedconf.conf.erb'
  variables(
    :port => "#{node['nginx']['port']}",
    :servername => "#{node['nginx']['servername']}",
    :webroot => "#{node['nginx']['webroot']}"
  )
end




#file '/var/www/wordpress' do
# content IO.read('/root/Chef/centos/


line = "127.0.0.1 #{node['nginx']['servername']}"
 file = Chef::Util::FileEdit.new('/etc/hosts')
 file.insert_line_if_no_match(/#{line}/, line)
 file.write_file

service ' php5-fpm' do
 action [:stop, :start]
end

service 'nginx' do
 action [:stop, :start]
end
              

