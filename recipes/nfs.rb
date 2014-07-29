# Cookbook Name:: netapp
# Recipe:: nfs

netapp_nfs "cluster2" do
  svm "cluster2"

  action:enable
end

netapp_nfs "cluster3" do

  action:disable
end