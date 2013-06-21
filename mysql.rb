# -*- encoding : utf-8 -*-
namespace :mysql do
  desc "Install mysql from package manager"
  task :install, :roles => :db do
    apt_install 'mysql-server'
  end
  after "deploy:install", "mysql:install"

  %w{start stop restart}.each do |command|
    desc "#{command} mysql"
    task command, :roles => :web do
      run "#{sudo} service mysql #{command}"
    end
  end
end
