#
# Cookbook Name:: chef-lvm
# Recipe:: default
#
# Copyright (C) 2014 PE, pf.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
include_recipe 'lvm::default'

package 'reiserfsprogs' do
  action :upgrade
end

node['lvm_volume_group'].each do |vg|
  if vg['name'] && vg['physical_volumes'] && vg['physical_volumes'].any?

    lvm_volume_group vg['name'] do
      physical_volumes vg['physical_volumes']

      vg['logical_volume'].each do |lv|
        logical_volume lv['name'] do
          size         lv['size']
          filesystem   lv['filesystem']
          mount_point  lv['mount_point']
          stripes      lv['stripes'] if lv['stripes']
          mirrors      lv['mirrors'] if lv['mirrors']
        end
      end if vg['logical_volume']

    end
  end
end

