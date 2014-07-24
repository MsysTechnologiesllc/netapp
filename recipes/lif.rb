# Cookbook Name:: netapp
# Recipe:: lif

netapp_lif "demo-interface" do
  address "192.168.1.200"
  home_node "cluster1-01"
  home_port "e0a"
  role "cluster_mgmt"
  svm "cluster1"
  netmask "255.255.255.0"

  action :create
end

netapp_lif "demo-del-interface" do
  svm "cluster1"

  action :delete
end