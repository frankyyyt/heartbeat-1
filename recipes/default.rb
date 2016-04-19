#
# Cookbook Name:: heartbeat
# Recipe:: default
#
# Copyright 2009-2015, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'yum-epel::default' if platform_family?('rhel')

case node['platform_family']
when 'rhel', 'fedora'
  package_list = ['heartbeat', 'heartbeat-devel']
when 'debian'
  package_list = ['heartbeat', 'heartbeat-dev']
end
package_list.each do |pkg|
  package pkg do
    action :install
  end
end

service 'heartbeat' do
  supports(
    restart: true,
    status: true
  )
  action :enable
end
