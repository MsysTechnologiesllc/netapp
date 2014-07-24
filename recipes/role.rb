# Cookbook Name:: netapp
# Recipe:: role

netapp_role "demo-role" do
  svm "demo-svm"
  command_directory "volume"

  action :create
end

netapp_role "demo-del-role" do
  svm "demo-svm"
  command_directory "DEFAULT"

  action :delete
end