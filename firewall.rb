# -*- encoding : utf-8 -*-
namespace :ufw do
  desc "Install firewall from package manager"
  task :install do
    sudo 'ufw allow ssh'
    sudo 'ufw --force enable'

    sudo 'ufw allow http', :roles => :web
    sudo 'ufw allow https', :roles => :web
  end
  after 'deploy:install', 'ufw:install'
end
