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

LBB_PROJECT_ROOT = "/vagrant/MoonBox/portal"

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
      server_admin "personal_email@pose.com"
      server_name "shop.pose.dev"
      docroot "#{LBB_PROJECT_ROOT}/web"
      docmainroot "#{LBB_PROJECT_ROOT}"
      server_port "80"
      servel_ssl_port "443"
      server_prefix "shop.pose"
      server_suffix ".dev"
      ssl_crt "shop.pose.dev.crt"
      ssl_key "shop.pose.dev.key"
    end

    web_app "admin.pose.dev" do
      template "web_app_admin.conf.erb"
      server_admin "personal_email@pose.com"
      server_name "admin.pose.dev"
      docroot "#{LBB_PROJECT_ROOT}/web_admin"
      docmainroot "#{LBB_PROJECT_ROOT}"
      server_port "80"
      servel_ssl_port "443"
      server_prefix "shop.pose"
      server_suffix ".dev"
      ssl_crt "shop.pose.dev.crt"
      ssl_key "shop.pose.dev.key"
    end

    directory "/etc/apache2/ssl" do
      action :create
    end
    
    cookbook_file "/etc/apache2/ssl/shop.pose.dev.crt" do
      source "shop.pose.dev.crt"
    end
    
    cookbook_file "/etc/apache2/ssl/shop.pose.dev.key" do
      source "shop.pose.dev.key"
    end
    
    cookbook_file "/etc/apache2/mods-available/deflate.conf" do
      source "deflate.conf"
    en

    directory "#{LBB_PROJECT_ROOT}/log" do
      action :create
      mode 0777
    end

    directory "#{LBB_PROJECT_ROOT}/cache" do
      action :create
      mode 0777
    end

    cookbook_file "#{LBB_PROJECT_ROOT}/config/databases.yml" do
      source "databases.yml"
    end
    
    execute "initialize LBB dev database" do
      command "mysql -u root --password=password -e 'DROP DATABASE IF EXISTS lbb; CREATE DATABASE IF NOT EXISTS lbb;'"
    end

    execute "initialize LBB test database" do
      command "mysql -u root --password=password -e 'DROP DATABASE IF EXISTS lbb_test; CREATE DATABASE IF NOT EXISTS lbb_test'"
    end

    %w(model sql).each do |phase|
      execute "./symfony doctrine:build-#{phase}" do
        cwd LBB_PROJECT_ROOT
      end
    end


