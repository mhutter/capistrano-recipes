# -*- encoding : utf-8 -*-
# set_default(:postgresql_host, "localhost")
# set_default(:postgresql_user) { application }
# set_default(:postgresql_password) { Capistrano::CLI.password_prompt "PostgreSQL Password: " }
# set_default(:postgresql_database) { "#{application}_production" }

namespace :postgresql do
  desc "install the latest stable release of PostgreSQL and client libraries."
  task :install do
    # Set up per https://wiki.postgresql.org/wiki/Apt
    sudo 'wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -'
    put_as_root "deb http://apt.postgresql.org/pub/repos/apt/ #{ubuntu_release_codename}-pgdg main", '/etc/apt/sources.list.d/pgdg.list'
    sudo 'apt-get -qq update'
    apt_install 'postgresql', :roles => :db
    apt_install 'libpq-dev' # All servers need to be able to compile against this
  end
  after "deploy:install", "postgresql:install"

  # desc "Create a database for this application"
  # task :create_database, :roles => :db, :only => {:primary => true} do
  #   run %Q{#{sudo} -u postgres psql -c "create user #{postgresql_user} with password '#{postgresql_password}';"}
  #   run %Q{#{sudo} -u postgres psql -c "create database #{postgresql_database} owner #{postgresql_user};"}
  # end
  # after "deploy:setup", "postgresql:create_database"

  # desc "Generate the database.yml config file"
  # task :setup, :roles => :app do
  #   run "mkdir -p #{shared_path}/config"
  #   template "postgresql.yml.erb", "#{shared_path}/config/database.yml"
  # end
  # after "deploy:setup", "postgresql:setup"

  # desc "Symlink the database.yml file into latest release"
  # task :symlink, :roles => :app do
  #   run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  # end
  # after "deploy:finalize_update", "postgresql:symlink"
end
