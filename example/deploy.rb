# Example config/deploy.rb file for use with capistrano-recipes

# Essential configuration
set :application, "app_name" # <- Make sure you at least set this!
set :domain, "#{application}.com"
set :repository, "git@github.com:your_github_account/#{application}.git"

# If you've got a single server, modify this block accordingly
server "ip.or.hostname", :web, :app, :db, :primary => true # CONFIGURE THIS...
set :deploy_to, "/srv/www/#{application}"
set :branch, "master"

# If you have multiple servers, do something like the following instead of
# the block above. See the docs for more information:
# https://github.com/capistrano/capistrano/wiki/2.x-Multistage-Extension
# set :stages, %w(production staging)
# set :default_stage, "staging"
# require 'capistrano/ext/multistage'

# Settings common to install and deploy
set :user, "deploy" # This is not easily changeable, as recipes depend on it
set :use_sudo, false

# Server install configuration
# set :ruby_version, "1.9"          # default 1.9
# set :use_rmagick, true            # default false
# set :root_mail_recipient, 'admin@example.com'
load 'config/deploy/install.rb'

##### EVERYTHING BELOW RELATES TO DEPLOYMENT
# You can delete it if you're just doing server setup.

# Deployment settings
# Make sure to use bundler!
set :scm, :git
ssh_options[:forward_agent] = true
# Don't want Darwin-only (OS X-only) gems installed on Linux servers
set :bundle_without, [:darwin, :development, :test]
set :rake_cmd, 'bundle exec rake'

require 'bundler/capistrano'

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
