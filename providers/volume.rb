# Cookbook Name:: netapp
# Provider:: aggregate
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
  netapp_volume_api = netapp_hash

  netapp_volume_api[:api_name] = "volume-create"
  netapp_volume_api[:resource] = "volume"
  netapp_volume_api[:action] = "create"
  netapp_volume_api[:svm] = new_resource.svm
  netapp_volume_api[:api_attribute]["containing-aggr-name"] = new_resource.aggregate
  netapp_volume_api[:api_attribute]["volume"] = new_resource.name
  netapp_volume_api[:api_attribute]["size"] = new_resource.size
  netapp_volume_api[:api_attribute]["constituent-role"] = new_resource.role if new_resource.role
  netapp_volume_api[:api_attribute]["export-policy"] = new_resource.export_policy if new_resource.export_policy
  netapp_volume_api[:api_attribute]["constituent-role"] = new_resource.role if new_resource.role
  netapp_volume_api[:api_attribute]["flexcache-cache-policy"] = new_resource.flexcache_cache_policy if new_resource.flexcache_cache_policy
  netapp_volume_api[:api_attribute]["flexcache-fill-policy"] = new_resource.flexcache_fill_policy if new_resource.flexcache_fill_policy
  netapp_volume_api[:api_attribute]["group-id"] = new_resource.group_id if new_resource.group_id
  netapp_volume_api[:api_attribute]["is-junction-active"] = new_resource.is_junction_active if new_resource.is_junction_active
  netapp_volume_api[:api_attribute]["is-nvfail-enabled"] = new_resource.is_nvfail_enabled if new_resource.is_nvfail_enabled
  netapp_volume_api[:api_attribute]["is-vserver-root"] = new_resource.is_vserver_root if new_resource.is_vserver_root
  netapp_volume_api[:api_attribute]["junction-path"] = new_resource.junction_path if new_resource.junction_path
  netapp_volume_api[:api_attribute]["language-code"] = new_resource.language if new_resource.language
  netapp_volume_api[:api_attribute]["max-dir-size"] = new_resource.max_dir_size if new_resource.max_dir_size
  netapp_volume_api[:api_attribute]["max-write-alloc-blocks"] = new_resource.max_write_alloc_blocks if new_resource.max_write_alloc_blocks
  netapp_volume_api[:api_attribute]["percentage-snapshot-reserve"] = new_resource.percentage_snapshot if new_resource.percentage_snapshot
  netapp_volume_api[:api_attribute]["qos-policy-group-name"] = new_resource.qos_policy_group if new_resource.qos_policy_group
  netapp_volume_api[:api_attribute]["snapshot-policy"] = new_resource.snapshot_policy if new_resource.snapshot_policy
  netapp_volume_api[:api_attribute]["space-reserve"] = new_resource.space_reserve if new_resource.space_reserve
  netapp_volume_api[:api_attribute]["storage-service"] = new_resource.storage_service if new_resource.storage_service
  netapp_volume_api[:api_attribute]["unix-permissions"] = new_resource.unix_permission if new_resource.unix_permission
  netapp_volume_api[:api_attribute]["user-id"] = new_resource.user_id if new_resource.user_id
  netapp_volume_api[:api_attribute]["vm-align-sector"] = new_resource.vm_align_sector if new_resource.vm_align_sector
  netapp_volume_api[:api_attribute]["vm-align-suffix"] = new_resource.vm_align_sector if new_resource.vm_align_sector
  netapp_volume_api[:api_attribute]["volume-comment"] = new_resource.comment if new_resource.comment
  netapp_volume_api[:api_attribute]["volume-security-style"] = new_resource.security_style if new_resource.security_style
  netapp_volume_api[:api_attribute]["volume-state"] = new_resource.state if new_resource.state
  netapp_volume_api[:api_attribute]["volume-type"] = new_resource.type if new_resource.type

  # Invoke NetApp API.
  invoke(netapp_feature_api)
end

action :delete do

  # The state of volume should be offline before deleting the volume.
  # Change the state of volume to offline from online.
  netapp_volume_offline_api = netapp_hash

  netapp_volume_offline_api[:api_name] = "volume-offline"
  netapp_volume_offline_api[:resource] = "volume"
  netapp_volume_offline_api[:action] = "offline"
  netapp_volume_offline_api[:svm] = new_resource.svm
  netapp_volume_offline_api[:api_attribute]["name"] = new_resource.name

  # Invoke NetApp API for volume offine.
  invoke(netapp_volume_offline_api)

  # Create API Request.
  netapp_volume_api = netapp_hash

  netapp_volume_api[:api_name] = "volume-destroy"
  netapp_volume_api[:resource] = "volume"
  netapp_volume_api[:action] = "delete"
  netapp_volume_api[:svm] = new_resource.svm
  netapp_volume_api[:api_attribute]["name"] = new_resource.name

  # Invoke NetApp API to destroy volume
  invoke(netapp_volume_api)
end