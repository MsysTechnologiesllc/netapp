#
# Author:: Arjun Hariharan (<Arjun.Hariharan@Clogeny.com>)
# Cookbook Name:: netapp
# Resource:: nfs
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

attribute :svm, :kind_of => String, :required => true
attribute :pathname, :kind_of => String, :required => true, :name_attribute => true

attribute :persistent, :kind_of => [TrueClass, FalseClass]
attribute :verbose, :kind_of => [TrueClass, FalseClass]
attribute :anon, :kind_of => String
attribute :nosuid, :kind_of => [TrueClass, FalseClass]

attribute :read_only_all_hosts, :kind_of => [TrueClass, FalseClass]
attribute :read_only_name, :kind_of => String
attribute :read_only_negate, :kind_of => [TrueClass, FalseClass]
attribute :read_write_all_hosts, :kind_of => [TrueClass, FalseClass]
attribute :read_write_name, :kind_of => String
attribute :read_write_negate, :kind_of => [TrueClass, FalseClass]
attribute :root_all_hosts, :kind_of => [TrueClass, FalseClass]
attribute :root_name, :kind_of => String
attribute :root_negate, :kind_of => [TrueClass, FalseClass]
attribute :flavor, :kind_of => Array