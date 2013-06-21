# -*- encoding : utf-8 -*-
namespace :deploy_user do
  desc "Create deploy user and app directory"
  task :install, :roles => [:app, :web] do
    sudo "useradd -m deploy"
    sudo "usermod -L deploy"
    sudo "mkdir ~deploy/.ssh"
    sudo "cp ~/.ssh/authorized_keys ~deploy/.ssh"
    sudo "chown -R deploy:deploy ~deploy/.ssh"
    sudo "chmod 700 ~deploy/.ssh"
    sudo "chmod 600 ~deploy/.ssh/authorized_keys"

    sudo "mkdir -p #{deploy_to}"
    sudo "chown deploy:deploy #{deploy_to}"
  end
  after "deploy:install", "deploy_user:install"

end
