# Cookbook Name:: netapp
# Recipe:: cleanup

netapp_role "demo-role" do
  svm "demo-svm"
  command_directory "volume"

  action :delete
end

netapp_user "demo-user" do
  vserver "demo-svm"
  application "ontapi"
  authentication "password"

  action :delete
end

netapp_lif "demo-interface" do
  svm "cluster1"

  action :delete
end

netapp_qtree '/vol/root_vs/demo-tree' do
  svm "demo-svm"

  action :delete
end

netapp_volume 'root_vs' do
  svm "demo-svm"

  action :delete
end

netapp_svm 'demo-svm' do
  action :delete
end

netapp_aggregate "aggr4" do
  action :delete
end

netapp_group "krb_unix" do
  position 5
  svm "cluster-infinite"

  action :delete
end

netapp_iscsi "cluster2" do
  action :delete
end