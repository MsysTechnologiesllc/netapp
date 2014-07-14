# Cookbook Name:: netapp
# Recipe:: default

#Examples

# netapp_svm "arjun-test" do
#   security "unix"
#   aggregate "aggr1"
#   volume "vol_arj"
#   nsswitch ["nis"]
#
#   action :create
# end

# netapp_feature "foo" do
#   codes ["CAYHXPKBFDUFZGABGAAAAAAAAAAA"]
#
#   action :enable
# end

# netapp_role "clo-test" do
#   svm "arjun-test"
#   command_directory "volume"
#
#   action :create
# end

# netapp_role "clo-test1" do
#   svm "arjun-test"
#   command_directory "DEFAULT"
#
#   action :delete
# end

# netapp_user "clo-user" do
#   vserver "arjun-test"
#   role "clo-test"
#   application "ontapi"
#   authentication "password"
#   password "clotest001"
#
#   action :create
# end

# netapp_user "clo-user" do
#   vserver "arjun-test"
#   application "ontapi"
#   authentication "password"

#   action :delete
# end

# netapp_iscsi "clo-test" do
#   svm "arjun-test"
# end

# netapp_lif "clo-interface" do
#   address "192.168.1.200"
#   home_node "cluster1-01"
#   home_port "e0a"
#   role "cluster_mgmt"
#   svm "cluster1"
#   netmask "255.255.255.0"

#   action :create
# end

netapp_lif "clo-interface" do
  svm "cluster1"

  action :delete
end
