#
# Cookbook Name:: php5_ppa
# Recipe:: from_ondrej
#
# Copyright (C) 2013 sawanoboly
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


execute "apt-get update" do
  command "apt-get -y update"
end

execute "apt-get install php5" do
  command "apt-get -y install php5"
end

execute "apt-get install php5-cgi" do
  command "apt-get -y install php5-cgi"
end

execute "apt-get install php5-fpm" do
  command "apt-get -y install php5-fpm"
end

execute "apt-get install php-memcache" do
  command "apt-get -y install php5-memcache"
end

execute "apt-get install php-apc" do
  command "apt-get -y install php-apc"
end

execute "apt-get install php5-mysqlnd" do
  command "apt-get -y install php5-mysqlnd"
end

execute "apt-get install php5-curl" do
  command "apt-get -y install php5-curl"
end

execute "apt-get install libapache2-mod-php5filter" do
  command "apt-get -y install libapache2-mod-php5filter"
end

execute "apt-get install libapache2-mod-php5" do
  command "apt-get -y install libapache2-mod-php5"
end

execute "apt-get install php-pear" do
  command "apt-get -y install php-pear"
end

apt_repository "ondrej-php-#{node["lsb"]["codename"]}" do
  uri "http://ppa.launchpad.net/ondrej/php5/ubuntu"
  distribution node["lsb"]["codename"]
  components ["main"]
  keyserver node["php5_ppa"]["keyserver"]
  key "E5267A6C"
  action :add
  notifies :run, "execute[apt-get update]", :immediately
end
