mysql_server_installation_package 'default' do
  version "5.5"
  action :install
end
mysql_client_installation_package 'default' do
  version "5.5"
  action :create
end