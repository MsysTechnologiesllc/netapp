# Cookbook Name:: netapp
# Provider:: feature
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

action :enable do

  #validations.
  new_resource.codes.each do |code|
    if (code.length !=24 && code.length != 48) && code != code.upcase
      raise ArgumentError, "Invalid code \"#{code}\". Code should be 24 or 48 uppercase alpha only characters."
    end
  end

  # Create API Request.
  request = NaElement.new("license-v2-add")
  codes = NaElement.new("codes")

  new_resource.codes.each do |code|
    license_code = NaElement.new("license-code-v2", code)
    codes.child_add(license_code)
  end

  # Invoke NetApp API.
  request.child_add(codes)
  result = invoke_elem(request)

  # Check the result for any errors.
  check_result(result, "feature","enable")
end
