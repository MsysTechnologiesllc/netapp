# Cookbook Name:: netapp
# Provider:: svm
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
  # validations
  raise ArgumentError, "Aggregate name should be less than 255 characters" if new_resource.name.length > 255

  # Create API Request.
  #netapp_aggr_api = Hash.new(&blk)
  netapp_aggr_api = netapp_hash

  netapp_aggr_api[:api_name] = "aggr-create"
  netapp_aggr_api[:resource] = "aggregate"
  netapp_aggr_api[:action] = "create"
  netapp_aggr_api[:api_attribute]["aggregate"] = new_resource.name
  netapp_aggr_api[:api_attribute]["allow-mixed-rpm"] = new_resource.allow_mixed_rpm if new_resource.allow_mixed_rpm
  netapp_aggr_api[:api_attribute]["allow-same-carrier"] = new_resource.allow_same_carrier if new_resource.allow_same_carrier
  netapp_aggr_api[:api_attribute]["block-type"] = new_resource.block_type if new_resource.block_type
  netapp_aggr_api[:api_attribute]["checksum-style"] = new_resource.checksum_style if new_resource.checksum_style
  netapp_aggr_api[:api_attribute]["disk-count"] = new_resource.disk_count if new_resource.disk_count
  netapp_aggr_api[:api_attribute]["disk-size"] = new_resource.disk_size if new_resource.disk_size
  netapp_aggr_api[:api_attribute]["disk-size-with-unit"] = new_resource.disk_size_with_unit if new_resource.disk_size_with_unit
  netapp_aggr_api[:api_attribute]["disk-type"] = new_resource.disk_type if new_resource.disk_type
  netapp_aggr_api[:api_attribute]["disks"] = new_resource.disks if new_resource.disks
  netapp_aggr_api[:api_attribute]["force-small-aggregate"] = new_resource.force_small_aggregate if new_resource.force_small_aggregate
  netapp_aggr_api[:api_attribute]["force-spare-pool"] = new_resource.force_spare_pool if new_resource.force_spare_pool
  netapp_aggr_api[:api_attribute]["ignore-pool-checks"] = new_resource.ignore_pool_checks if new_resource.ignore_pool_checks
  netapp_aggr_api[:api_attribute]["is-mirrored"] = new_resource.is_mirrored if new_resource.is_mirrored

  #Todo- verify
  netapp_aggr_api[:api_attribute]["mirror-disks"]["disk-info"]["name"] = new_resource.mirror_disks if new_resource.mirror_disks

  netapp_aggr_api[:api_attribute]["nodes"] = new_resource.nodes if new_resource.nodes
  netapp_aggr_api[:api_attribute]["pre-check"] = new_resource.pre_check if new_resource.pre_check
  netapp_aggr_api[:api_attribute]["raid-size"] = new_resource.raid_size if new_resource.raid_size
  netapp_aggr_api[:api_attribute]["raid-type"] = new_resource.raid_type if new_resource.raid_type
  netapp_aggr_api[:api_attribute]["rpm"] = new_resource.rpm if new_resource.rpm
  netapp_aggr_api[:api_attribute]["striping"] = new_resource.striping if new_resource.striping

  # Invoke NetApp API.
  invoke(netapp_aggr_api)
end

action :delete do
  # Create API Request.
  netapp_aggr_api = netapp_hash

  netapp_aggr_api[:api_name] = "aggr-destroy"
  netapp_aggr_api[:resource] = "aggregate"
  netapp_aggr_api[:action] = "create"
  netapp_aggr_api[:api_attribute]["aggregate"] = new_resource.name
  netapp_aggr_api[:api_attribute]["plex"] = new_resource.plex if new_resource.plex

  # Invoke NetApp API.
  invoke(netapp_aggr_api)
end