#
# Cookbook Name:: lbbphp
# Recipe:: default
#
# Copyright 2013, Example Com
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

include_recipe "apache2::default"

    php_pear_channel "pear.phpunit.de" do
      action :discover
    end

    php_pear_channel "pear.symfony-project.com" do
      action :discover
    end

    php_pear_channel "pear.symfony.com" do
      action :discover
    end

    php_pear_channel "components.ez.no" do
      action :discover
    end

    php_net = php_pear_channel "pear.php.net" do
      action :discover
    end

    php_unit = php_pear_channel "pear.phpunit.de" do
      action :discover
    end

    php_pear "PEAR" do
      cur_version = `pear -V| head -1| awk -F': ' '{print $2}'`
      action :upgrade
      not_if { Gem::Version.new(cur_version) > Gem::Version.new('1.9.0') }
    end

    php_pear "Net_URL2" do
      channel php_net.channel_name
      version "2.0.0"
      action :install
    end

    php_pear "HTTP_Request2" do
      channel php_net.channel_name
      version "2.0.0"
      action :install
    end

    php_pear "PHPUnit" do
      channel php_unit.channel_name
      action :install
    end

    web_app "shop.pose.dev" do
      server_name "shop.pose.dev"
      docroot "/vagrant/MoonBox/portal/web"
      server_port "80"
    end

    web_app "admin.pose.dev" do
      server_name "admin.pose.dev"
      docroot "/vagrant/MoonBox/portal/web_admin"
      server_port "80"
    end

    web_app "shop.pose.dev" do
      server_name "admin.pose.dev"
      docroot "/vagrant/MoonBox/portal/web"
      server_port "443"
    end




