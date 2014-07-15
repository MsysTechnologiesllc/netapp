# Cookbook Name:: netapp
# Recipe:: cleanup

netapp_role "example-role" do
  svm "example-svm"
  command_directory "DEFAULT"

  action :delete
end

netapp_user "exmple-user" do
  vserver "example-svm"
  application "ontapi"
  authentication "password"

  action :delete
end

netapp_lif "example-interface" do
  svm "cluster1"

  action :delete
end

netapp_qtree '/vol/root_vs/example-tree' do
  svm "example-svm"

  action :delete
end

netapp_volume 'example-vol' do
  svm "example-test"

  action :delete
end