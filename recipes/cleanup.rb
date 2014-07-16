# Cookbook Name:: netapp
# Recipe:: cleanup

netapp_role "example-role" do
  svm "example-svm"
  command_directory "volume"

  action :delete
end

netapp_user "example-user" do
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

netapp_volume 'example_vol' do
  svm "cluster2"

  action :delete
end

netapp_volume 'root_vs' do
  svm "example-svm"

  action :delete
end

netapp_svm 'example-svm' do
  action :delete
end