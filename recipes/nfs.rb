# Cookbook Name:: netapp
# Recipe:: nfs

netapp_nfs "demo-nfs" do
  svm "cluster2"

  action:create
end

netapp_nfs "demo-del-nfs" do
  svm "cluster2"

  action:delete
end