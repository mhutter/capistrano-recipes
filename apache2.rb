# -*- encoding : utf-8 -*-
namespace :apache2 do
  desc "Install apache2 from package manager"
  task :install, :roles => :web do
    apt_install 'apache2'
  end
  after "deploy:install", "apache2:install"

  %w{start stop restart}.each do |command|
    desc "#{command} apache2"
    task command, :roles => :web do
      run "#{sudo} service apache2 #{command}"
    end
  end
end
