# -*- encoding : utf-8 -*-
namespace :mongodb do
  desc "install the latest stable release of MongoDB"
  task :install, roles: :db do
    run "#{sudo} apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10"
    run "#{sudo} apt-add-repository -y 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen'"
    run "#{sudo} apt-get -qq update"
    run "#{sudo} apt-get -yq install mongodb-10gen"
  end
  after "deploy:install", "mongodb:install"

  desc "Setup MongoDB config for this app"
  task :setup, roles: :app do
    run "mkdir -p #{shared_path}/config"
    template "mongoid.yml", "#{shared_path}/config/mongoid.yml"
  end

  %w{start stop restart}.each do |command|
    desc "#{command} mongodb"
    task command, roles: :db do
      run "#{sudo} service mongodb #{command}"
    end
  end
end
