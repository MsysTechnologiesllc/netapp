# Cookbook Name:: netapp
# Recipe:: nfs

netapp_nfs "my_nfs" do
  svm "cluster2"

  action:create
end

netapp_nfs "my_nfs" do
  svm "cluster2"

  action:delete
end