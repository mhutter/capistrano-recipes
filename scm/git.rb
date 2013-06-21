# -*- encoding : utf-8 -*-
namespace :git do
  desc "Set up git"
  task :install, :roles => [:app, :web] do
    apt_install 'git-core'
  end
  after "deploy:install", "git:install"
end
