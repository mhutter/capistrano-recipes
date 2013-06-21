namespace :passenger do
  desc "Set up Passenger for use with Apache"
  task :install, :roles => :app do
    apt_install 'libcurl4-openssl-dev apache2-threaded-dev libapr1-dev libaprutil1-dev'
    sudo 'gem install passenger'
    sudo 'passenger-install-apache2-module --auto'
    sudo 'passenger-install-apache2-module --snippet > /tmp/passenger.load'
    sudo 'mv /tmp/passenger.load /etc/apache2/mods-available/passenger.load'
    sudo 'a2enmod passenger'
    sudo 'service apache2 restart'
  end
  after "deploy:install", "passenger:install"
end
