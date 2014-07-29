# Cookbook Name:: netapp
# Provider:: iscsi
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

  # Create API Request.
  netapp_iscsi_api = netapp_hash

  netapp_iscsi_api[:api_name] = "iscsi-service-create"
  netapp_iscsi_api[:resource] = "iscsi"
  netapp_iscsi_api[:action] = "create"
  netapp_iscsi_api[:svm] = new_resource.name
  netapp_iscsi_api[:api_attribute]["alias-name"] = new_resource.alias if new_resource.alias
  netapp_iscsi_api[:api_attribute]["node-name"] = new_resource.node_name if new_resource.node_name
  netapp_iscsi_api[:api_attribute]["start"] = new_resource.start if new_resource.start

  # Invoke NetApp API.
  invoke(netapp_iscsi_api)
end

action :delete do

  # Create API Request.
  netapp_iscsi_offline_api = netapp_hash

  netapp_iscsi_offline_api[:api_name] = "iscsi-service-stop"
  netapp_iscsi_offline_api[:resource] = "iscsi"
  netapp_iscsi_offline_api[:action] = "offline"
  netapp_iscsi_offline_api[:svm] = new_resource.name

 # Invoke NetApp API.
  invoke(netapp_iscsi_offline_api)

  netapp_iscsi_api = netapp_hash

  netapp_iscsi_api[:api_name] = "iscsi-service-destroy"
  netapp_iscsi_api[:resource] = "iscsi"
  netapp_iscsi_api[:action] = "delete"
  netapp_iscsi_api[:svm] = new_resource.name

 # Invoke NetApp API.
  invoke(netapp_iscsi_api)
end