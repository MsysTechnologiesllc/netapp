# Cookbook Name:: netapp
# Recipe:: user

netapp_user 'test' do
  password 'foobar'
  groups ['admins']
  action :create
end

# netapp_user 'test' do
#   action :delete
# end