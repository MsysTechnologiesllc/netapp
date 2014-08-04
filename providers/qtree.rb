# Cookbook Name:: netapp
# Provider:: qtree
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

  #validations.
  raise ArgumentError, "Attribute volume is required for qtree creation" unless new_resource.volume

  # Create API Request.
  netapp_qtree_api = netapp_hash

  netapp_qtree_api[:api_name] = "qtree-create"
  netapp_qtree_api[:resource] = "qtree"
  netapp_qtree_api[:action] = "create"
  netapp_qtree_api[:svm] = new_resource.svm
  netapp_qtree_api[:api_attribute]["qtree"] = new_resource.name
  netapp_qtree_api[:api_attribute]["volume"] = new_resource.volume
  netapp_qtree_api[:api_attribute]["export-policy"] = new_resource.export_policy unless new_resource.export_policy.nil?
  netapp_qtree_api[:api_attribute]["mode"] = new_resource.mode unless new_resource.mode.nil?
  netapp_qtree_api[:api_attribute]["oplocks"] = new_resource.oplocks unless new_resource.oplocks.nil?
  netapp_qtree_api[:api_attribute]["security-style"] = new_resource.security unless new_resource.security.nil?

  # Invoke NetApp API.
  resource_update = invoke(netapp_qtree_api)
  new_resource.updated_by_last_action(true) if resource_update
end

action :delete do

  # Create API Request.
  netapp_qtree_api = netapp_hash

  netapp_qtree_api[:api_name] = "qtree-delete"
  netapp_qtree_api[:resource] = "qtree"
  netapp_qtree_api[:action] = "delete"
  netapp_qtree_api[:svm] = new_resource.svm
  netapp_qtree_api[:api_attribute]["qtree"] = new_resource.name
  netapp_qtree_api[:api_attribute]["force"] = new_resource.force unless new_resource.force.nil?

  # Invoke NetApp API.
  resource_update = invoke(netapp_qtree_api)
  new_resource.updated_by_last_action(true) if resource_update
end
