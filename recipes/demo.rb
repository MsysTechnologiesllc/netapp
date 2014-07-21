# Cookbook Name:: netapp
# Recipe:: demo


netapp_aggregate "aggr4" do
  disk_count 5
  action :create
end

netapp_svm "demo-svm" do
  security "unix"
  aggregate "aggr1"
  volume "root_vs"
  nsswitch ["nis", "file"]

  action :create
end

netapp_feature "demo-feature" do
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
  password "demopwd001"

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

netapp_iscsi "cluster2" do
  action :create
end

netapp_nfs "/vol/root_vs" do
  svm "demo-svm"
  read_only_all_hosts true

  action :create
end

netapp_group "krb_unix" do
  position 5
  pattern "cifs"
  replacement "EXAMPLE\\Domain Groups"
  svm "cluster-infinite"

  action :create
end