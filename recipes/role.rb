# Cookbook Name:: netapp
# Recipe:: role

netapp_role "exmple-role" do
  svm "exmple-svm"
  command_directory "volume"

  action :create
end

netapp_role "example-role" do
  svm "example-svm"
  command_directory "DEFAULT"

  action :delete
end