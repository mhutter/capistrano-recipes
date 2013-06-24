# -*- encoding : utf-8 -*-
require "bundler/capistrano"

load "config/recipes/base"
# below here, comment out the ones you don't need
load "config/recipes/nginx"
load "config/recipes/unicorn"
load "config/recipes/postgresql"
load "config/recipes/nodejs"
load "config/recipes/rbenv"
load "config/recipes/newrelic"
load "config/recipes/newrelic_sysmond"
load "config/recipes/uploads"
load "config/recipes/check"
# load "config/recipes/custom_config"

server "ip.or.hostname", :web, :app, :db, :primary => true

set :application, "app_name"  # configure at least THIS...
set :domain, "#{application}.com"
set :user, "deploy"         # ...THIS...
set :deploy_to, "/srv/www/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false # this may be a bit misleading, the user on the server still needs sudo-rights!

set :scm, :git
set :repository, "git@github.com:your_github_account/#{application}.git" # ...and THIS.
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:migrate"
after "deploy", "deploy:cleanup" # last 5 releases

# and maybe some of THIS
# set :ruby_version, "1.9.3-p194"   # default 1.9.3-p194
# set :use_rmagick, true            # default false
# set :newrelic_key, "???"          # required for `newrelic` and `newrelic_sysmond`
