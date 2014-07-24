# Cookbook Name:: netapp
# Recipe:: feature

netapp_feature "demo-feature" do
  codes ["CAYHXPKBFDUFZGABGAAAAAAAAAAA"]

  action :enable
end