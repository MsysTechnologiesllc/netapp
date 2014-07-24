# Cookbook Name:: netapp
# Recipe:: iscsi

netapp_iscsi "cluster2" do
  action :create
end

netapp_iscsi "cluster2" do
  action :delete
end