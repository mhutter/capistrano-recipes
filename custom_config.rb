# -*- encoding : utf-8 -*-

namespace :custom_config do
  task :create_symlink, roles: :app do
    run "ln -nfs #{shared_path}/config/custom.yml #{release_path}/config/custom.yml"
  end
  after "deploy:finalize_update", "custom_config:create_symlink"
end
