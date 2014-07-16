# Cookbook Name:: netapp
# Recipe:: user

netapp_user "exmple-user" do
  vserver "demo-svm"
  role "demo-role"
  application "ontapi"
  authentication "password"
  password "demo001"

  action :create
end

netapp_user "exmple-user" do
  vserver "demo-svm"
  application "ontapi"
  authentication "password"

  action :delete
end