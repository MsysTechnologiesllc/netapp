# Cookbook Name:: netapp
# Recipe:: aggregate

netapp_aggregate "aggr-demo" do
  disk_count 5
  action :create
end

netapp_aggregate "aggr-del-demo" do
  action :delete
end