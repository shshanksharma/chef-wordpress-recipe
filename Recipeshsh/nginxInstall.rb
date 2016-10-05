#apt_update if node['platform_family'] == 'debian' do
# action :update
#end

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


