# -*- encoding : utf-8 -*-
namespace :nodejs do
  desc "Install the latest release of Node.js"
  task :install, :roles => :app do
    sudo "add-apt-repository -y ppa:chris-lea/node.js"
    sudo "apt-get -qq update"
    sudo "apt-get -yq install nodejs"
  end
  after "deploy:install", "nodejs:install"
end
