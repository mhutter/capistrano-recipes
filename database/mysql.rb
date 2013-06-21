# -*- encoding : utf-8 -*-
namespace :mysql do
  desc "Install mysql from package manager"
  task :install, :roles => :db do
    apt_install 'mysql-server'

    password = request_root_password

    if password.to_s != '' &&
      run(%Q(mysql -u root -e "UPDATE mysql.user SET Password = PASSWORD('#{password}') WHERE User = 'root'; FLUSH PRIVILEGES;"))
    end
  end
  after "deploy:install", "mysql:install"

  %w{start stop restart}.each do |command|
    desc "#{command} mysql"
    task command, :roles => :db do
      sudo "service mysql #{command}"
    end
  end

  def request_root_password
    password = Capistrano::CLI.ui.ask("What should the MySQL root user's password be?") { |q| q.echo = false }
    password_confirm = Capistrano::CLI.ui.ask("One more time, please:") { |q| q.echo = false }
    if password.to_s == password_confirm.to_s
      password
    else
      puts "SORRY! YOUR ENTRIES DID NOT MATCH"
      request_root_password
    end
  end
end
