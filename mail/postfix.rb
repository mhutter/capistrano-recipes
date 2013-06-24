namespace :postfix do
  desc "Install postfix MTA"
  task :install, :roles => :app do
    apt_install 'postfix'
  end
  after "deploy:install", "postfix:install"
end
