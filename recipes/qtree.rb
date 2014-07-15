# Cookbook Name:: netapp
# Recipe:: qtree

netapp_qtree 'example-tree' do
  volume "root_vs"
  svm "example-svm"

  action :create
end

netapp_qtree '/vol/root_vs/example-tree' do
  svm "example-svm"

  action :delete
end