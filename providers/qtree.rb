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

action :create do
  params = []
  params.push("qtree", new_resource.name)
  params.push("volume", new_resource.volume)
  params.push("mode", new_resource.mode) if new_resource.mode
  params.push("export_policy", new_resource.export_policy) if new_resource.export_policy
  params.push("oplocks", new_resource.oplocks) if new_resource.oplocks
  params.push("security", new_resource.security) if new_resource.security

  result = invoke("qtree-create",params)

end

action :delete do
  params = []
  params.push("qtree", new_resource.name)
  prarms.push("force", new_resource.force) if new_resource.force

  result = invoke("qtree-delete", params)
end
