# Cookbook Name:: netapp
# Recipe:: demo


netapp_svm "example-svm" do
  security "unix"
  aggregate "aggr1"
  volume "root_vs"
  nsswitch ["nis"]

  action :create
end

netapp_feature "foo" do
  codes ["CAYHXPKBFDUFZGABGAAAAAAAAAAA"]

  action :enable
end

netapp_role "exmple-role" do
  svm "exmple-svm"
  command_directory "volume"

  action :create
end

netapp_user "exmple-user" do
  vserver "example-svm"
  role "example-role"
  application "ontapi"
  authentication "password"
  password "example001"

  action :create
end

netapp_lif "example-interface" do
  address "192.168.1.200"
  home_node "cluster1-01"
  home_port "e0a"
  role "cluster_mgmt"
  svm "cluster1"
  netmask "255.255.255.0"

  action :create
end

netapp_qtree 'example-tree' do
  volume "root_vs"
  svm "example-svm"

  action :create
end

netapp_volume 'example-vol' do
  svm "example-svm"
  aggregate "aggr1"
  size "2.5g"

  action :create
end