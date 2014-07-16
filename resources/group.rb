#
# Author:: Arjun Hariharan (<Arjun.Hariharan@Clogeny.com>)
# Cookbook Name:: netapp
# Resource:: group
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

attribute :direction, :kind_of => String, :equal_to => ["krb_unix", "win_unix", "unix_win"], :required => true
attribute :svm, :kind_of => String, :required => true
attribute :position, :kind_of => Integer, :required => true
attribute :pattern, :kind_of => String
attribute :replacement, :kind_of => String
attribute :return_record, :kind_of => [TrueClass, FalseClass]