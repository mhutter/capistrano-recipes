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
load "config/recipes/uploads"
load "config/recipes/check"

server "ip.or.hostname", :web, :app, :db, primary: true

set :application, "app_name"  # configure at least THIS...
set :user, "deployer"         # ...THIS...
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, :git
set :repository,  "git@github.com:your_github_account/#{application}.git" # ...and THIS.
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # last 5 releases

# and maybe some of THIS
# set :ruby_version, "1.9.3-p194"   # default 1.9.3-p194
# set :use_rmagick, true            # default false
# set :use_rbenv_gemset, false      # default true
# set :newrelic_key, "???"          # default false, which will prevent config-file creation
