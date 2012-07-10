set_default(:postgresql_host, "localhost")
set_default(:postgresql_user) { application }
set_default(:postgresql_password) { Capistrano::CLI.password_prompt "PostgreSQL Password: " }
set_default(:postgresql_database) { "#{application}_production" }

namespace :postgresql do
  desc "install the latest stable release of PostgreSQL."
  task :install, roles: :db, only: {primary: true} do
    unless ['12.04'].include?(lsb_release)
      # unless we run 12.04 (which has the latest version in the repos)
      # we need to add the backports archive
      run "#{sudo} add-apt-repository -y ppa:pitti/postgresql"
    end
    run "#{sudo} apt-get -qq update"
    run "#{sudo} apt-get -yq install postgresql libpq-dev" # TODO I think libpq-dev is needed on the APP server
  end
  after "deploy:install", "postgresql:install"
  
  desc "Create a database for this application"
  task :create_database, roles: :db, only: {primary: true} do
    run %Q{#{sudo} -u postgres psql -c "create user #{postgresql_user} with password '#{postgresql_password}';"}
    run %Q{#{sudo} -u postgres psql -c "create database #{postgresql_database} owner #{postgresql_user};"}
  end
  after "deploy:setup", "postgresql:create_database"
  
  desc "Generate the database.yml config file"
  task :setup, roles: :app do
    run "mkdir -p #{shared_path}/config"
    template "postgresql.yml.erb", "#{shared_path}/config/database.yml"
  end
  after "deploy:setup", "postgresql:setup"
  
  desc "Symlink the database.yml file into latest release"
  task :symlink, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "postgresql:symlink"
end
