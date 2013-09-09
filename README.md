Capistrano Recipe Collection
============================
[Capistrano](http://www.capistranorb.com/) is a remote multi-server automation tool. This collection of recipes helps you set up a new Rails server. This functionality is similar to [Capistrano's `deploy:cold`](https://github.com/capistrano/capistrano/wiki/2.x-From-The-Beginning#about-deploycold).

This branch is for Ubuntu 12.04. Check the git branches if you're using another Linux.

Usage
======

Setting up new server(s)
------

1. Add `capistrano` and `capistrano-ext` to your Gemfile.
2. Run `capify .` to bootstrap your application for Capistrano.
3. `git submodule add -b ubuntu12.04.2 git@github.com:singlebrook/capistrano-recipes.git config/recipes`
4. `git submodule update --init`
5. Create yourself a sudoer user on each server:
  * `adduser [you] --ingroup sudo`
  * `sudo su [you]`
  * add your public key to your `~/.ssh/authorized_keys`
  * set permissions: `chmod -R og-rwx ~/.ssh`
6. `sudo vi /etc/sudoers.d/passwordless` to contain the following:

    \# Allow members of group sudo to execute any command with no password
    %sudo   ALL=(ALL) NOPASSWD: ALL

7. `sudo chmod 440 /etc/sudoers.d/passwordless`
8. Copy files from deploy example: `cp -r config/deploy/recipes/example/* config/deploy`
9. Make sure you've pushed any local changes to the git server.
10. `Run cap [level] deploy:install -s user=[your sudoer]`
11. `Run cap [level] deploy:setup`
12. `Run cap [level] deploy`
13. Upload your database.

Credits
=======
* [Original project by mhutter](https://github.com/mhutter/capistrano-recipes)
* [Railscasts](http://railscasts.com/)
