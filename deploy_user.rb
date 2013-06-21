# -*- encoding : utf-8 -*-
namespace :deploy_user do
  desc "Create deploy user and app directory"
  task :install, :roles => [:app, :web] do
    run "#{sudo} useradd -m deploy"
    run "#{sudo} usermod -L deploy"
    run "#{sudo} mkdir ~deploy/.ssh"
    run "#{sudo} cp ~/.ssh/authorized_keys ~deploy/.ssh"
    run "#{sudo} chown -R deploy:deploy ~deploy/.ssh"
    run "#{sudo} chmod 700 ~deploy/.ssh"
    run "#{sudo} chmod 600 ~deploy/.ssh/authorized_keys"

    run "#{sudo} mkdir -p #{deploy_to}"
    run "#{sudo} chown deploy:deploy #{deploy_to}"
  end
  after "deploy:install", "deploy_user:install"

end
