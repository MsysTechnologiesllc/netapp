# Cookbook Name:: netapp
# Recipe:: user

netapp_user "exmple-user" do
  vserver "example-svm"
  role "example-role"
  application "ontapi"
  authentication "password"
  password "example001"

  action :create
end

netapp_user "exmple-user" do
  vserver "example-svm"
  application "ontapi"
  authentication "password"

  action :delete
end