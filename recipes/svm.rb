# Cookbook Name:: netapp
# Recipe:: svm

netapp_svm "example-svm" do
  security "unix"
  aggregate "aggr1"
  volume "root_vs"
  nsswitch ["nis"]

  action :create
end