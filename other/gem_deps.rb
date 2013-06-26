# -*- encoding : utf-8 -*-
namespace :gemdeps do
  desc "Install dependencies for compiling various gems"

  task :install, :roles => :app do
    apt_install 'libxslt-dev libxml2-dev' # For Nokogiri
  end

  before 'bundle:install', 'gemdeps:install'
end