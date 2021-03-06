include_recipe 'limber::default'
include_recipe 'database::mysql'

mysql_connection = {:host => 'localhost',
                    :username => 'root',
                    :password => node['mysql']['server_root_password']}

mysql_database node['app']['db']['schema'] do
  connection mysql_connection
  action :create
end

mysql_database_user node['app']['db']['user'] do
  connection mysql_connection
  password node['app']['db']['password']
  database_name node['app']['db']['schema']
  action [:create]
end

mysql_database_user node['app']['db']['user'] do
  connection mysql_connection
  password node['app']['db']['password']
  database_name node['app']['db']['schema']
  host 'localhost'
  privileges [:select, :update, :insert, :delete]
  action [:grant]
end

mysql_database_user node['app']['db']['user'] do
  connection mysql_connection
  password node['app']['db']['password']
  database_name node['app']['db']['schema']
  host '%'
  privileges [:select, :update, :insert, :delete]
  action [:grant]
end

include_recipe 'minitest-handler'
