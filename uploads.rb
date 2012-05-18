set_default(:upload_path) { "#{shared_path}/uploads" }

namespace :uploads do
  desc "Creates a shared folder for Uploads"
  task :setup, roles: :web do
    run "mkdir -p #{upload_path}"
  end
  after "deploy:setup", "uploadss:setup"
  
  desc "Symlinks the uploads to the current public folder"
  task :create_symlink, roles: :web do
    run "ln -nfs #{upload_path} #{current_path}/public/"
  end
  after "deploy:create_symlink", "uploads:create_symlink"
end
