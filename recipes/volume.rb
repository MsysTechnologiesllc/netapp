# Cookbook Name:: netapp
# Recipe:: volume

netapp_volume 'demo_vol' do
  svm "cluster2"
  aggregate "aggr1"
  size "250m"

  action :create
end

netapp_volume 'demo_vol' do
  svm "cluster2"

  action :delete
end