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

  # validations.
  raise ArgumentError, "Invalid protocol \"#{protocol}\". It must be nfs/cifs/iscsi/fcp/fcache/none" unless new_resource.home_node
  raise ArgumentError, "Invalid protocol \"#{protocol}\". It must be nfs/cifs/iscsi/fcp/fcache/none" unless new_resource.home_port
  raise ArgumentError, "Invalid protocol \"#{protocol}\". It must be nfs/cifs/iscsi/fcp/fcache/none" unless new_resource.role

  if new_resource.data_protocols
    new_resource.data_protocols.each do |protocol|
      raise ArgumentError, "Invalid protocol \"#{protocol}\". It must be nfs/cifs/iscsi/fcp/fcache/none" unless ["nfs", "cifs", "iscsi", "fcp", "fcache", "none"].include? protocol
    end
  end

  # Create API Request.
  request = NaElement.new("net-interface-create")

  request.child_add_string("vserver", new_resource.svm)
  request.child_add_string("home-node", new_resource.home_node)
  request.child_add_string("home-port", new_resource.home_port)
  request.child_add_string("interface-name", new_resource.name)
  request.child_add_string("role", new_resource.role)

  request.child_add_string("address", new_resource.address) if new_resource.address
  request.child_add_string("administrative-status", new_resource.administrative_status) if new_resource.administrative_status
  request.child_add_string("comment", new_resource.comment) if new_resource.comment

  if new_resource.data_protocols
    data_protocols = NaElemen.new("data-protocols")

    new_resource.data_protocols.each do  |protocol|
      data_protocols.child_add_string("data-protocol", protocol)
    end
    request.child_add(data_protocols)
  end

  if new_resource.failover_group
    failover_group = NaElement.new("failover_group")
    failover_group_info = NaElement.new("failover_group", new_resource.failover_group)
    failover_group.child_add(failover_group_info)
    request.child_add(failover_group)
  end

  request.child_add_string("failover-policy", new_resource.failover_policy) if new_resource.failover_policy
  request.child_add_string("firewall-policy", new_resource.firewall_policy) if new_resource.firewall_policy
  request.child_add_string("is-auto-revert", new_resource.is_auto_revert) if new_resource.is_auto_revert
  request.child_add_string("is-ipv4-link-local", new_resource.is_ipv4_link_local) if new_resource.is_ipv4_link_local
  request.child_add_string("listen-for-dns-query", new_resource.listen_for_dns_query) if new_resource.listen_for_dns_query
  request.child_add_string("netmask", new_resource.netmask) if new_resource.netmask
  request.child_add_string("netmask-length", new_resource.netmask_length) if new_resource.netmask_length
  request.child_add_string("return-record", new_resource.return_record) if new_resource.return_record

  if new_resource.routing_group_name
    routing_group = NaElement.new("routing-group", new_resource.routing_group)
    routing_group_name = NaElement.new("routing-group-name")
    routing_group_name.child_add(routing_group)
    request.child_add(routing_group_name)
  end

  request.child_add_string("use-failover-group", new_resource.use_failover_group) if new_resource.use_failover_group

  # Invoke NetApp API.
  result = invoke_elem(request)

  # Check the result for any errors.
  if result.results_errno != 0
    raise "Net interface creation failed.Error no- #{result.results_errno}. Reason- #{result.results_reason}."
  end
end

action :delete do

  # Create API Request.
  request = NaElement.new("net-interface-delete")

  request.child_add_string("vserver", new_resource.svm)
  request.child_add_string("interface-name", new_resource.name)

  # Invoke NetApp API.
  result = invoke_elem(request)

  # Check the result for any errors.
  if result.results_errno != 0
    raise "Net interface deletion failed.Error no- #{result.results_errno}. Reason- #{result.results_reason}."
  end
end