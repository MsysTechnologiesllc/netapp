#
# Author:: Arjun Hariharan (<Arjun.Hariharan@Clogeny.com>)
# Cookbook Name:: netapp
# Resource:: user
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

actions :create, :delete
default_action :create

attribute :name, :kind_of => String, :required => true, :name_attribute => true
attribute :application, :kind_of => String, :required => true, :equal_to => ["console", "http", "ontapi", "rsh", "snmp", "sp", "ssh", "telnet"]
attribute :vserver, :kind_of => String, :required => true
attribute :authentication_method, :kind_of => String, :required => true, :equal_to => ["community", "password", "publickey", "domain", "nsswitch", "usm"]

#optional parameters
attribute :role_name, :kind_of => String  # This parameters is required for user creation.
attribute :password, :kind_of => String
attribute :comment, :kind_of => String

#These parameters are required only for 'usm' authentication method
attribute :authentication_password, :kind_of => String
attribute :authentication_protocol, :kind_of => String, :equal_to => ["none", "md5", "sha"]
attribute :privacy_password, :kind_of => String
attribute :privacy_protocol, :kind_of => String, :equal_to => ["none", "des"]
attribute :engine_id, :kind_of => String