# Cookbook Name:: netapp
# Recipe:: aggregate

netapp_aggregate "aggr4" do
  disk_count 5
  action :create
end

netapp_aggregate "aggr4" do
  action :delete
end