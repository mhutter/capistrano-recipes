# Capistrano Recipe Collection
[Capistrano][] is a remote multi-server automation tool.

## About
Developed and tested for Ubuntu 12.04

### About the Recipes included

* **base**
  contains the task to which all other reciepes hook in. Also installs some software dependencies

* **check**
  makes sure the local GIT repo is in sync with the remote repo before the code is deployed

* **figaro**
  symlinks your custom `application.yml` file for [Figaro][]

* **nginx**
  installs, configures and controls [nginx][]. (Installed from [ppa:nginx/stable][ppa-nginx])

* **nodejs**
  installs [node.js][] from [ppa:chris-lea/node.js][ppa-nodejs]

* **postgresql**
  installs, configures and controls [PostgreSQL][]. Also installs the dependencies for the [pg gem][].

* **rbenv**
  installs [rbenv][], [ruby-build][], [rbenv-gemset][] (if configured) and the dependencies to build Ruby.

* **unicorn**
  installs, configures and controls [unicorn][]

### Usage
Set up your `deploy.rb` according to this example:

```ruby
require "bundler/capistrano"

load "config/recipes/base"
# below here, comment out the ones you don't need
load "config/recipes/check"
# load "config/recipes/custom_config"
load "config/recipes/figaro"
load "config/recipes/newrelic"
load "config/recipes/newrelic_sysmond"
load "config/recipes/nginx"
load "config/recipes/nodejs"
load "config/recipes/postgresql"
load "config/recipes/rbenv"
load "config/recipes/unicorn"
load "config/recipes/uploads"


server "ip.or.hostname", :web, :app, :db, primary: true

set :application, "app_name"  # configure at least THIS...
set :domain, "#{application}.com"
set :user, "deployer"         # ...THIS...
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false # this may be a bit misleading, the user on the server still needs sudo-rights!

set :scm, :git
set :repository,  "git@github.com:your_github_account/#{application}.git" # ...and THIS.
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:migrate"
after "deploy", "deploy:cleanup" # last 5 releases

# and maybe some of THIS
# set :ruby_version, "2.0.0-p247"   # default 2.0.0-p247
# set :use_rmagick, true            # default false
# set :use_rbenv_gemset, true      # default false
# set :newrelic_key, "???"          # required for `newrelic` and `newrelic_sysmond`
```

For configuration options on specific recipes, see the `set_default` statements in the according source files.

You can find this `deploy.rb` file in the `example/` subdirectory.

## Credits
* [Railscasts][]


[Capistrano]: https://github.com/capistrano/capistrano
[Figaro]: https://github.com/laserlemon/figaro
[nginx]: http://nginx.org
[node.js]: http://nodejs.org
[pg gem]: https://rubygems.org/gems/pg
[PostgreSQL]: http://www.postgresql.org
[ppa-nginx]: https://launchpad.net/~nginx/+archive/stable
[ppa-nodejs]: https://launchpad.net/~chris-lea/+archive/node.js/
[Railscasts]: http://railscasts.com
[rbenv-gemset]: https://github.com/jamis/rbenv-gemset
[rbenv]: https://github.com/sstephenson/rbenv
[ruby-build]: https://github.com/sstephenson/ruby-build
[unicorn]: http://unicorn.bogomips.org
