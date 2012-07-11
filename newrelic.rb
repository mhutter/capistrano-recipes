set_default(:newrelic_key, false)
set_default(:newrelic_config) { "#{shared_path}/config/newrelic.yml" }

namespace :newrelic do
  desc "Set up New Relic RPM Config for this App"
  task :setup, roles: :web do
    template "newrelic.yml.erb", newrelic_config if newrelic_key
  end
  after "deploy:setup", "newrelic:setup"
  
  task :create_symlink, roles: :web do
    run "ln -nfs #{newrelic_config} #{release_path}/config/newrelic.yml" if newrelic_key
  end
  after "deploy:create_symlink", "newrelic:create_symlink"
end