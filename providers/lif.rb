# Cookbook Name:: netapp
# Provider:: lif
#
# Copyright:: 2014, Chef Software, Inc <legal@getchef.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include NetApp::Api

action :create do
  unless exists?
    #TODO create lif
  end

  *params = "net-interface-create"
  params.push("vserver", new_resource.svm)
  params.push("interface-name", new_resource.name)
  params.push("data-protocols", new_resource.protocols) if new_resource.protocols
  params.push("home-port", new_resource.home_port) if new_resource.home_port
  params.push("address", new_resource.ip_address) if new_resource.ip_address
  params.push("netmask", new_resource.network_mask) if new_resource.network_mask
  params.push("home_node", new_resource.home_node) if new_resource.home_node

  result = invoke(params)
end

action :delete do
  if exists?
    #TODO delete lif
  end

  result = invoke("net-interface-delete", "interface-name", new_resource.name, "vserver", new_resource.svm)
end

private
  def exists?
    #TODO check if lif  exists
    true
  end