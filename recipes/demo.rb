# Cookbook Name:: netapp
# Recipe:: demo


netapp_svm "demo-svm" do
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

netapp_role "demo-role" do
  svm "demo-svm"
  command_directory "volume"

  action :create
end

netapp_user "demo-user" do
  vserver "demo-svm"
  role "demo-role"
  application "ontapi"
  authentication "password"
  password "demo001"

  action :create
end

netapp_lif "demo-interface" do
  address "192.168.1.200"
  home_node "cluster1-01"
  home_port "e0a"
  role "cluster_mgmt"
  svm "cluster1"
  netmask "255.255.255.0"

  action :create
end

netapp_qtree 'demo-tree' do
  volume "root_vs"
  svm "demo-svm"

  action :create
end