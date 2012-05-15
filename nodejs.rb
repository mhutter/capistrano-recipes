namespace :nodejs do
  desc "Install the latest release of Node.js"
  task :install, roles: :app do
    run "#{sudo} add-apt-repository -y ppa:chris-lea/node.js"
    run "#{sudo} apt-get -qq update"
    run "#{sudo} apt-get -y install nodejs"
  end
  after "deploy:install", "nodejs:install"
end