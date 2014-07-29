# Cookbook Name:: netapp
# Recipe:: iscsi

netapp_iscsi "demo-cluster" do
  action :create
end

netapp_iscsi "demo-del-cluster" do
  action :delete
end