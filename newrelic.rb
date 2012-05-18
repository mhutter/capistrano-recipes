set_default(:newrelic_key, false)
set_default(:newrelic_config) { "#{shared_path}/config/newrelic.yml" }
set_default(:use_newrelic) { !!newrelic_key }

namespace :newrelic do
  desc "Set up New Relic RPM Config for this App"
  task :setup, roles: :web do
    if use_newrelic
      template "newrelic.yml.erb", newrelic_config
    end
  end
  after "deploy:setup", "newrelic:setup"
  
  task :create_symlink, roles: :web do
    if use_newrelic
      run "ln -nfs #{newrelic_config} #{release_path}/config/newrelic.yml"
    end
  end
  after "deploy:create_symlink", "newrelic:create_symlink"
end