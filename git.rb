# -*- encoding : utf-8 -*-
namespace :git do
  desc "Set up git"
  task :install, :roles => [:app, :web] do
    run "#{sudo} DEBIAN_FRONTEND=noninteractive apt-get -yq install git-core"
  end
  after "deploy:install", "git:install"
end
