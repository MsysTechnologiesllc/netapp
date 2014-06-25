# Cookbook Name:: netapp
# Recipe:: default

netapp_user 'test' do
  password 'foobar'
  groups ['admins']
  action :create
end