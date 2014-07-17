# Cookbook Name:: netapp
# Recipe:: qtree

netapp_qtree 'demo-tree' do
  volume "root_vs"
  svm "demo-svm"

  action :create
end

netapp_qtree '/vol/root_vs/demo-tree' do
  svm "demo-svm"

  action :delete
end