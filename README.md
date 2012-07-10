Capistrano Recipe Collection
============================
[Capistrano][] is a remote multi-server automation tool.

About
=====
Developed and tested for Ubuntu 12.04

About the Recipes included
---

* **base**
  contains the task to which all other reciepes hook in. Also installs some software dependencies

* **check**
  makes sure the local GIT repo is in sync with the remote repo before the code is deployed

* **nginx**
  installs, configures and controls [nginx][]. (Installed from [ppa:nginx/stable][ppa-nginx])

* **nodejs**
  installs [node.js][] from [ppa:chris-lea/node.js][ppa-nodejs]
  
* **postgresql**
  installs, configures and controls [PostgreSQL][]. Also installs the dependencies for the [pg gem][].

* **rbenv**
  installs [rbenv][], [ruby-build][], [rbenv-gemset][] and the dependencies to build Ruby.

* **unicorn**
  installs, configures and controls [unicorn][]

Usage
-----
Set up your `deploy.rb` according to this example:

```ruby
# -*- encoding : utf-8 -*-
require "bundler/capistrano"

load "config/recipes/base"
# below here, comment out the ones you don't need
load "config/recipes/nginx"
load "config/recipes/unicorn"
load "config/recipes/postgresql"
load "config/recipes/nodejs"
load "config/recipes/rbenv"
load "config/recipes/check"

server "ip.or.hostname", :web, :app, :db, primary: true

set :application, "app_name"  # configure at least THIS...
set :user, "deployer"         # ...THIS...
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false # this may be a bit misleading, the user on the server still needs sudo-rights!

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
```
For configuration options on specific recipes, see the `set_default` statements in the according source files.

You can find this `deploy.rb` file in the `example/` subdirectory.

Credits
=======
* [Railscasts][]


[Capistrano]: https://github.com/capistrano/capistrano
[nginx]: http://nginx.org
[ppa-nginx]: https://launchpad.net/~nginx/+archive/stable
[node.js]: http://nodejs.org
[ppa-nodejs]: https://launchpad.net/~chris-lea/+archive/node.js/
[PostgreSQL]: http://www.postgresql.org
[pg gem]: https://rubygems.org/gems/pg
[rbenv]: https://github.com/sstephenson/rbenv
[ruby-build]: https://github.com/sstephenson/ruby-build
[rbenv-gemset]: https://github.com/jamis/rbenv-gemset
[Railscasts]: http://railscasts.com
[unicorn]: http://unicorn.bogomips.org
