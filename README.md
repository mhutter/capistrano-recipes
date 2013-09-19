Capistrano Recipe Collection
============================
[Capistrano](http://www.capistranorb.com/) is a remote multi-server automation tool.

This collection of recipes helps you set up new servers. This functionality is similar to [Capistrano's `deploy:cold`](https://github.com/capistrano/capistrano/wiki/2.x-From-The-Beginning#about-deploycold).

This branch is for Ubuntu 12.04. Check the git branches if you're using another Linux.

Usage
======

Setting up new server(s)
------

1. If capistrano will be used for app deployment, add `capistrano` and `capistrano-ext` to the :development section of your Gemfile and run `bundle install`. Otherwise, run `gem install capistrano capistrano-ext` if you're just using capistrano for server setup.
2. Run `capify .` to bootstrap your application for Capistrano.
3. `git submodule add -b ubuntu12.04.2 git@github.com:singlebrook/capistrano-recipes.git config/deploy/recipes`
4. `git submodule update --init`
5. Create yourself a sudoer user on each server:
  * `adduser [you] --ingroup sudo`
  * `su [you]`
  * add your public key to your `~/.ssh/authorized_keys`
  * set permissions: `chmod -R og-rwx ~/.ssh`
6. `sudo vi /etc/sudoers.d/passwordless` to contain the following:

    \# Allow members of group sudo to execute any command with no password
    %sudo   ALL=(ALL) NOPASSWD: ALL

7. `sudo chmod 440 /etc/sudoers.d/passwordless`
8. If you're not already using capistrano for deployment, copy the example `config/deploy.rb`:

    cp -r config/deploy/recipes/example/deploy.rb config/deploy.rb

  If you are using capistrano already, review `example/deploy.rb` and make sure you've got all of the necessary settings. You'll definitely need the `load 'config/install.rb'` line.

9. Copy the example recipe selection file:

    cp -r config/deploy/recipes/example/deploy/install.rb config/install.rb

  and modify it as necessary for your desired configuration.

10. `Run cap [level] deploy:install -s user=[your sudoer]`

Credits
=======
* [Original project by mhutter](https://github.com/mhutter/capistrano-recipes)
* [Railscasts](http://railscasts.com/)
