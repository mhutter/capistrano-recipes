# -*- encoding : utf-8 -*-
namespace :mongoid do
  desc "Setup mongoid config for this app"
  task :setup, roles: :app do
    run "mkdir -p #{shared_path}/config"
    template "mongoid.yml", "#{shared_path}/config/mongoid.yml"
  end

  task :create_symlink, roles: :app do
    run "ln -nfs #{shared_path}/config/mongoid.yml #{release_path}/config/mongoid.yml"
  end
  after "deploy:create_symlink", "mongoid:create_symlink"
end
