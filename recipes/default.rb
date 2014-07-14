# Cookbook Name:: netapp
# Recipe:: default

#Examples

# netapp_svm "arjun-test" do
#   security "unix"
#   aggregate "aggr1"
#   volume "vol_arj"
#   nsswitch ["nis"]

#   action :create
# end

netapp_feature "foo" do
  codes ["CAYHXPKBFDUFZGABGAAAAAAAAAAA"]
  action :enable
end