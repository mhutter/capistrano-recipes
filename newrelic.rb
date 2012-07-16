set_default(:newrelic_config) { "#{shared_path}/config/newrelic.yml" }
set_default(:newrelic_sysmond, false)

namespace :newrelic do
  desc "Set up New Relic RPM Config for this App"
  task :setup, roles: :web do
    template "newrelic.yml.erb", newrelic_config
    if newrelic_sysmond
      run "#{sudo} wget -q -O /etc/apt/sources.list.d/newrelic.list http://download.newrelic.com/debian/newrelic.list"
      run "#{sudo} apt-key adv --keyserver hkp://subkeys.pgp.net --recv-keys 548C16BF"
      run "#{sudo} apt-get -qq update"
      run "#{sudo} apt-get -yq install newrelic-sysmond"
      run "#{sudo} nrsysmond-config --set license_key=#{newrelic_key}"
      run "#{sudo} service newrelic-sysmond start"
    end
  end
  after "deploy:setup", "newrelic:setup"
  
  task :create_symlink, roles: :web do
    run "ln -nfs #{newrelic_config} #{release_path}/config/newrelic.yml"
  end
  after "deploy:create_symlink", "newrelic:create_symlink"
end