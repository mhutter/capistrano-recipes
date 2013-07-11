# -*- encoding : utf-8 -*-
# Example config/deploy.rb file for use with capistrano-recipes
server "ip.or.hostname", :web, :app, :db, :primary => true # CONFIGURE THIS...

set :application, "app_name"  # CONFIGURE THIS...
set :domain, "#{application}.com"
set :user, "deploy" # This is not easily changeable, as recipes depend on it
set :deploy_to, "/srv/www/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
set :scm, :git
set :repository, "git@github.com:your_github_account/#{application}.git" # ...and THIS.
set :branch, "master"
ssh_options[:forward_agent] = true

# Don't want Darwin-only (OS X-only) gems installed on Linux servers
set :bundle_without, [:darwin, :development, :test]

# Make sure to use bundler!
set :rake_cmd, 'bundle exec rake'

require 'capistrano/ext/multistage'
require 'bundler/capistrano'

# Load server install tasks
# set :ruby_version, "1.9"          # default 1.9
# set :use_rmagick, true            # default false
load 'config/deploy/install.rb'

task :symlinks do
  # Link to shared resources, if you have them in .gitignore
  # run "rm #{deploy_to}/current/config/database.yml"
  run "mkdir -p #{deploy_to}/shared/config"
  run "ln -sf #{deploy_to}/shared/config/database.yml #{deploy_to}/current/config/database.yml"
end

after "deploy", "deploy:migrate"
after "deploy", "deploy:cleanup" # last 5 releases

after "deploy", :symlinks

# Uncomment if using whenever
# task :crontab do
#   # This replaces the section of the deploy user's crontab for this app
#   run_current "bundle exec whenever --update-crontab -i #{deploy_to} --set 'environment=#{rails_env}'"
# end
# after "deploy", :crontab
