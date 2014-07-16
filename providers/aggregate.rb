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
  # validations.
  raise ArgumentError, "Aggregate name should be less than 255 characters" if new_resource.name.length > 255
  new_resource.nsswitch.each do |switch|
    raise ArgumentError, "Invalid name-server-switch \"#{switch}\". It must be nis/file/ldap" unless ["nis", "file", "ldap"].include? switch
  end

  raise ArgumentError, "The maximum value for raid-size is 28" if new_resource.raid_size > 28

  # Create API Request.
  request =  NaElement.new("aggr-create")
  request.child_add_string("aggregate", new_resource.name)
  request.child_add_string("allow-mixed-rpm", new_resource.allow_mixed_rpm) if new_resource.allow_mixed_rpm
  request.child_add_string("allow-same-carrier", new_resource.allow_same_carrier) if new_resource.allow_same_carrier
  request.child_add_string("block-type", new_resource.block_type) if new_resource.block_type
  request.child_add_string("checksum-style", new_resource.checksum_style) if new_resource.checksum_style
  request.child_add_string("disk-count", new_resource.disk_count) if new_resource.disk_count
  request.child_add_string("disk-size", new_resource.disk_size) if new_resource.disk_size
  request.child_add_string("disk-size-with-unit", new_resource.disk_size_with_unit) if new_resource.disk_size_with_unit
  request.child_add_string("disk-type", new_resource.disk_type) if new_resource.disk_type
  request.child_add_string("disks", new_resource.disks) if new_resource.disks
  request.child_add_string("force-small-aggregate", new_resource.force_small_aggregate) if new_resource.force_small_aggregate
  request.child_add_string("force-spare-pool", new_resource.force_spare_pool) if new_resource.force_spare_pool
  request.child_add_string("ignore-pool-checks", new_resource.ignore_pool_checks) if new_resource.ignore_pool_checks
  request.child_add_string("is-mirrored", new_resource.is_mirrored) if new_resource.is_mirrored

  if new_resource.mirror_disks
    mirror_disks = NaElement.new("mirror-disks")

    new_resource.mirror_disks.each do |disk|
      disk = NaElement.new("disk-info")
      disk.child_add_string("name", disk)

      mirror_disks.child_add(disk)
    end

    request.child_add(mirror_disks)
  end

  if new_resource.nodes
    new_resource.nodes.each do |node|
      request.child_add_string("nodes", node)
    end
  end

  request.child_add_string("pre-check", new_resource.pre_check) if new_resource.pre_check
  request.child_add_string("raid-size", new_resource.raid_size) if new_resource.raid_size
  request.child_add_string("raid-type", new_resource.raid_type) if new_resource.raid_type
  request.child_add_string("rpm", new_resource.rpm) if new_resource.rpm
  request.child_add_string("striping", new_resource.striping) if new_resource.striping

  # Invoke NetApp API.
  result = invoke_api(request)

  # Check the result for any errors.
  check_result(result, "aggregate","create")
end

action :delete do
  # Create API Request.
  request =  NaElement.new("aggr-destroy")
  request.child_add_string("aggregate", new_resource.name)
  request.child_add_string("plex", new_resource.plex) if new_resource.plex

  # Invoke NetApp API.
  result = invoke_api(request)

  # Check the result for any errors.
 check_result(result, "aggregate","delete")
end