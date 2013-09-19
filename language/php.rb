# -*- encoding : utf-8 -*-
namespace :php do
  desc "Install PHP 5.3"
  task :install, :roles => :app do
    sudo "apt-get -yq install php5 php5-cli php5-common php5-curl php5-gd php5-mysql php-apc"
  end
  after "deploy:install", "php:install"
end
