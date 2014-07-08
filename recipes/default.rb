# Cookbook Name:: netapp
# Recipe:: default

# netapp_svm 'clogeny01' do
#   name_server_switch "nis"
#   volume "vol0"
#   aggregate "aggr1"
#   security "unix"
#   action :create
# end

netapp_aggregate 'aggr1' do
  action:create
end
