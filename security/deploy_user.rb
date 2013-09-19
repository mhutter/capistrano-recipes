# -*- encoding : utf-8 -*-
namespace :deploy_user do
  desc "Create deploy user and app directory"
  task :install, :roles => [:app, :web] do
    # Create user
    sudo "useradd -m -s /bin/bash deploy"

    # Lock user so they can't login with a password
    sudo "usermod -L deploy"

    # Copy sudoer user's authorized key (the one currently in use) into deploy's authorized keys
    sudo "mkdir ~deploy/.ssh"
    sudo "cp ~/.ssh/authorized_keys ~deploy/.ssh"
    sudo "chown -R deploy:deploy ~deploy/.ssh"
    sudo "chmod 700 ~deploy/.ssh"
    sudo "chmod 600 ~deploy/.ssh/authorized_keys"

    # Create deploy's public and private keys
    run "#{sudo} -u deploy ssh-keygen -q -t rsa -f /home/deploy/.ssh/id_rsa -N ''"
    sudo "cat /home/deploy/.ssh/id_rsa.pub"
    Capistrano::CLI.password_prompt("Pausing so you can copy the deploy user's public key (for Github access)...press return")

    # Load github's SSH fingerprint into the list of known hosts
    run "ssh-keyscan -H github.com | #{sudo} -u deploy tee -a /home/deploy/.ssh/known_hosts"

    # Create the deployment directory
    sudo "mkdir -p #{deploy_to}"
    sudo "chown deploy:deploy #{deploy_to}"
  end
  after "deploy:install", "deploy_user:install"

end
