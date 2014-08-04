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
  netapp_volume_api[:api_attribute]["constituent-role"] = new_resource.role unless new_resource.role.nil?
  netapp_volume_api[:api_attribute]["export-policy"] = new_resource.export_policy unless new_resource.export_policy.nil?
  netapp_volume_api[:api_attribute]["constituent-role"] = new_resource.role unless new_resource.role.nil?
  netapp_volume_api[:api_attribute]["flexcache-cache-policy"] = new_resource.flexcache_cache_policy unless new_resource.flexcache_cache_policy.nil?
  netapp_volume_api[:api_attribute]["flexcache-fill-policy"] = new_resource.flexcache_fill_policy unless new_resource.flexcache_fill_policy.nil?
  netapp_volume_api[:api_attribute]["group-id"] = new_resource.group_id unless new_resource.group_id.nil?
  netapp_volume_api[:api_attribute]["is-junction-active"] = new_resource.is_junction_active unless new_resource.is_junction_active.nil?
  netapp_volume_api[:api_attribute]["is-nvfail-enabled"] = new_resource.is_nvfail_enabled unless new_resource.is_nvfail_enabled.nil?
  netapp_volume_api[:api_attribute]["is-vserver-root"] = new_resource.is_vserver_root unless new_resource.is_vserver_root.nil?
  netapp_volume_api[:api_attribute]["junction-path"] = new_resource.junction_path unless new_resource.junction_path.nil?
  netapp_volume_api[:api_attribute]["language-code"] = new_resource.language unless new_resource.language.nil?
  netapp_volume_api[:api_attribute]["max-dir-size"] = new_resource.max_dir_size unless new_resource.max_dir_size.nil?
  netapp_volume_api[:api_attribute]["max-write-alloc-blocks"] = new_resource.max_write_alloc_blocks unless new_resource.max_write_alloc_blocks.nil?
  netapp_volume_api[:api_attribute]["percentage-snapshot-reserve"] = new_resource.percentage_snapshot unless new_resource.percentage_snapshot.nil?
  netapp_volume_api[:api_attribute]["qos-policy-group-name"] = new_resource.qos_policy_group unless new_resource.qos_policy_group.nil?
  netapp_volume_api[:api_attribute]["snapshot-policy"] = new_resource.snapshot_policy unless new_resource.snapshot_policy.nil?
  netapp_volume_api[:api_attribute]["space-reserve"] = new_resource.space_reserve unless new_resource.space_reserve.nil?
  netapp_volume_api[:api_attribute]["storage-service"] = new_resource.storage_service unless new_resource.storage_service.nil?
  netapp_volume_api[:api_attribute]["unix-permissions"] = new_resource.unix_permission unless new_resource.unix_permission.nil?
  netapp_volume_api[:api_attribute]["user-id"] = new_resource.user_id unless new_resource.user_id.nil?
  netapp_volume_api[:api_attribute]["vm-align-sector"] = new_resource.vm_align_sector unless new_resource.vm_align_sector.nil?
  netapp_volume_api[:api_attribute]["vm-align-suffix"] = new_resource.vm_align_sector unless new_resource.vm_align_sector.nil?
  netapp_volume_api[:api_attribute]["volume-comment"] = new_resource.comment unless new_resource.comment.nil?
  netapp_volume_api[:api_attribute]["volume-security-style"] = new_resource.security_style unless new_resource.security_style.nil?
  netapp_volume_api[:api_attribute]["volume-state"] = new_resource.state unless new_resource.state.nil?
  netapp_volume_api[:api_attribute]["volume-type"] = new_resource.type unless new_resource.type.nil?

  # Invoke NetApp API.
  resource_update = invoke(netapp_volume_api)
  new_resource.updated_by_last_action(true) if resource_update
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
  resource_update = invoke(netapp_volume_api)
  new_resource.updated_by_last_action(true) if resource_update
end