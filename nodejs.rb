namespace :nodejs do
  desc "Install the latest release of Node.js"
  task :install, roles: :app do
    run "#{sudo} add-apt-repository ppa:chris-lea/node.js"
    run "#{sudo} apt-get -qq update"
    run "#{sudo} apt-get -yq install nodejs"
  end
  after "deploy:install", "nodejs:install"
end
