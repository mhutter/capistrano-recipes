namespace :memcached do
  desc "Set up Memcached"
  task :install, :roles => :app do
    apt_install 'memcached'
  end
  after "deploy:install", "memcached:install"
end
