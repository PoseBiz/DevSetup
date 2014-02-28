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

LBB_PROJECT_ROOT = "/home/vagrant/MoonBox/portal"

#include_recipe "apache2::default"

    php_unit = php_pear_channel "pear.phpunit.de" do
      action :discover
    end

    php_pear_channel "pear.phpunit.de" do
      action :update
    end

     php_pear_channel "pear.symfony-project.com" do
       action :discover
     end

     php_pear_channel "pear.symfony-project.com" do
       action :update
     end    

     php_pear_channel "pear.symfony.com" do
       action :discover
     end

     php_pear_channel "pear.symfony.com" do
       action :update
     end

     php_pear_channel "components.ez.no" do
       action :discover
     end

     php_pear_channel "components.ez.no" do
       action :update
     end     

    # Pecl Channel

     php_pear_channel "pecl.php.net" do
       action :discover
     end       

     php_pear_channel "pecl.php.net" do
       action :update
     end  

    # Pear Channel

     php_net = php_pear_channel "pear.php.net" do
       action :discover
     end      

     php_pear_channel "pear.php.net" do
       action :update
     end 

     php_pear "PEAR" do
       cur_version = `pear -V| head -1| awk -F': ' '{print $2}'`
       action :upgrade
       not_if { Gem::Version.new(cur_version) > Gem::Version.new('1.9.0') }
     end

    web_app "shop.pose.dev" do
      server_admin "ish@pose.com"
      server_name "shop.pose.dev"
      docroot "#{LBB_PROJECT_ROOT}/web"
      docmainroot "#{LBB_PROJECT_ROOT}"
      server_port "80"
      server_ssl_port "443"
      server_prefix "shop.pose"
      server_suffix ".dev"
      ssl_crt "shop.pose.dev.crt"
      ssl_key "shop.pose.dev.key"
    end

    web_app "admin.pose.dev" do
      template "web_app_admin.conf.erb"
      server_admin "ish@pose.com"
      server_name "admin.pose.dev"
      docroot "#{LBB_PROJECT_ROOT}/web_admin"
      docmainroot "#{LBB_PROJECT_ROOT}"
      server_port "80"
      server_ssl_port "443"
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
    end

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

    # Elastic Search

    cookbook_file "/vagrant" do
      source "elasticsearch-0.90.7.deb"
    end

    execute "Install ElasticSearch" do
      command "sudo dpkg -i /vagrant/elasticsearch-0.90.7.deb"
    end

