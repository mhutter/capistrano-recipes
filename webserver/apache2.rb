# -*- encoding : utf-8 -*-
namespace :apache2 do
  desc "Install apache2 from package manager"
  task :install, :roles => :web do
    apt_install 'apache2'

    # Disable the default site
    sudo 'a2dissite default'

    put_as_root %Q( # Prevent warning about "Could not reliably determine the server's fully qualified domain name?"
                    ServerName localhost
      ).gsub(/^ +/, ''),
      '/etc/apache2/sites-available/default-name'
    sudo 'a2ensite default-name'
  end
  after "deploy:install", "apache2:install"

  %w{start stop restart}.each do |command|
    desc "#{command} apache2"
    task command, :roles => :web do
      sudo "service apache2 #{command}"
    end
  end
end
