#
# Author:: Arjun Hariharan (<Arjun.Hariharan@Clogeny.com>)
# Cookbook Name:: netapp
# Resource:: svm
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

attribute :name, :kind_of => String, :required => true, :name_attribute => true #vserver-name
attribute :nsswitch, :kind_of => Array
attribute :volume, :kind_of => String
attribute :aggregate, :kind_of => String
attribute :security, :kind_of => String, :equal_to => ["unix", "ntfs", "mixed", "unified"]

#optional attributes
attribute :comment, :kind_of => String
attribute :is_repository_vserver, :kind_of => [TrueClass, FalseClass], :default => false
attribute :language, :kind_of => String #TODO - default? the default language C.UTF-8 or POSIX.UTF-8 is used.???
attribute :nmswitch, :kind_of => Array
attribute :quota_policy, :kind_of => String
attribute :return_record, :kind_of => [TrueClass, FalseClass]
attribute :snapshot_policy, :kind_of => String