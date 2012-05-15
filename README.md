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
  installs, configures and controls [nginx][]. (Installed from [ppa:nginx/stable][ppa-nginx]

* **nodejs**
  installs [node.js][] from [ppa:chris-lea/node.js][ppa-nodejs]
  
* **postgresql**
  installs, configures and controls [PostgreSQL][]. Also installs the dependencies for the [pg gem][].

* **rbenv**
  installs [rbenv][], [ruby-build][], [rbenv-gemset][] and the dependencies to build Ruby.

* **unicorn**
  installs, configures and controls [unicorn][]

Configuration
-------------
See [deploy.rb][] in the `example` subdirectory to get an idea how this works. (You know where to put the deploy.rb-file, right?)

For configuration options on specific recipes, see the `set_default` statements in the according source files.


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
[deploy.rb]: https://github.com/mhutter/capistrano-recipes/blob/master/example/deploy.rb
[Railscasts]: http://railscasts.com

