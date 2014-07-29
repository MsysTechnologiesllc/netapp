# Cookbook Name:: netapp
# Recipe:: cleanup

netapp_group "unix_win" do
  position 1
  pattern "cifs"
  replacement "EXAMPLE\\Domain Groups"
  svm "cluster2"

  action :create
end

netapp_group "krb_unix" do
  position 1
  svm "cluster2"

  action :delete
end