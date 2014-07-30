# Cookbook Name:: netapp
# Recipe:: nfs

netapp_nfs "cluster1" do
  svm "cluster2"

  action :enable
end

netapp_nfs "cluster2" do

  action :disable
end

netapp_nfs "cluster3" do
  pathname "/vol/root_vs"
  read_write_all_hosts true

  action :add_rule
end

netapp_nfs "cluster4" do
  pathname "/vol/root_vs"
  persistent true
  read_write_all_hosts false

  action :modify_rule
end

netapp_nfs "cluster5" do

  action :delete_rule
end