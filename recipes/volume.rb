# Cookbook Name:: netapp
# Recipe:: volume

netapp_volume 'example-vol' do
  svm "example-svm"
  aggregate "aggr1"
  size "2.5g"

  action :create
end

netapp_volume 'example-vol' do
  svm "example-svm"

  action :delete
end