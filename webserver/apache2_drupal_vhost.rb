namespace :apache2_drupal_vhost do
  desc "Create a Drupal-ready apache2 vhost for [application]"
  task :install do
    put_as_root read_template('apache2_drupal_vhost.erb'), "/etc/apache2/sites-available/#{application}"
    sudo "a2ensite #{application}"
    sudo "service apache2 restart"
  end
  after 'deploy:install', 'apache2_drupal_vhost:install'
end
