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

    template "shop.pose.dev.conf" do
      source "shop.pose.dev.conf.erb"
      path "/etc/apache2/sites-available/shop.pose.dev.conf"
      variables(:params => {:server_admin=>"ish@pose.com",
        :server_name => "shop.pose.dev",
        :docroot => "#{LBB_PROJECT_ROOT}/web",
        :docmainroot => "#{LBB_PROJECT_ROOT}",
        :server_port => "80",
        :server_ssl_port => "443",
        :server_prefix => "shop.pose",
        :server_suffix => ".dev",
        :ssl_crt => "shop.pose.dev.crt",
        :ssl_key => "shop.pose.dev.key"})
    end

    template "admin.pose.dev.conf" do
      source "admin.pose.dev.conf.erb"
      path "/etc/apache2/sites-available/admin.pose.dev.conf"
      variables(:params => {:server_admin => "ish@pose.com",
        :server_name => "admin.pose.dev",
        :docroot => "#{LBB_PROJECT_ROOT}/web_admin",
        :docmainroot => "#{LBB_PROJECT_ROOT}",
        :server_port => "80",
        :server_ssl_port => "443",
        :server_prefix => "shop.pose",
        :server_suffix => ".dev",
        :ssl_crt => "shop.pose.dev.crt",
        :ssl_key => "shop.pose.dev.key"})
    end

    # PHP INIs

    cookbook_file "/etc/php5/apache2/php.ini" do
      source "apache2/php.ini"
    end

    cookbook_file "/etc/php5/cli/php.ini" do
      source "cli/php.ini"
    end    

    # Apache Files

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

    execute "a2enmod rewrite" do
      command "a2enmod rewrite"
    end

    execute "a2enmod ssl" do
      command "a2enmod ssl"
    end

    # Elastic Search

    remote_file "/vagrant/elasticsearch-0.90.7.deb" do
      source "https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.7.deb"
      action :create_if_missing
    end

    execute "Install ElasticSearch" do
      command "sudo dpkg -i /vagrant/elasticsearch-0.90.7.deb"
    end    

