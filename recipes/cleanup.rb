# Cookbook Name:: netapp
# Recipe:: cleanup

netapp_role "clo-test1" do
  svm "arjun-test"
  command_directory "DEFAULT"

  action :delete
end

netapp_user "clo-user" do
  vserver "arjun-test"
  application "ontapi"
  authentication "password"

  action :delete
end

netapp_lif "clo-interface" do
  svm "cluster1"

  action :delete
end
