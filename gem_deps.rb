# -*- encoding : utf-8 -*-
namespace :gemdeps do
  desc "Install dependencies for compiling various gems"

  task :install, roles: :app do
    packages = %w(libxslt-dev libxml2-dev) # For Nokogiri
    run "#{sudo} apt-get -yqq install #{packages.join(' ')}"
  end

  before 'bundle:install', 'gemdeps:install'
end