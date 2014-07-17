# Cookbook Name:: netapp
# Recipe:: cleanup

netapp_group "demo_group" do
  direction "unix_win"
  position 1
  pattern "cifs"
  replacement "EXAMPLE\\Domain Groups"
  svm "cluster2"

  action :create
end

netapp_group "demo_group" do
  direction "unix_win"
  position 1
  svm "cluster2"

  action :delete
end