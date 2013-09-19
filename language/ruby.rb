# -*- encoding : utf-8 -*-
set_default :ruby_version, "ruby1.9"
set_default :use_rmagick, false

# This uses Brightbox's Ruby packages for Ubuntu
namespace :ruby do
  desc "Install Ruby, Ruby prequisites, Ruby and the Bundler gem"
  task :install, :roles => :app do
    # install prerequisites
    apt_install 'curl git-core build-essential zlib1g-dev openssl libssl-dev libreadline-dev'
    if use_rmagick
      apt_install 'imagemagick libmagickcore-dev libmagickwand-dev'
    end
    sudo "apt-add-repository --remove -y ppa:brightbox/ruby-ng"
    sudo "apt-add-repository -y ppa:brightbox/ruby-ng-experimental"
    sudo "apt-get -qq update"
    apt_install 'ruby rubygems ruby-switch'
    sudo "ruby-switch --set #{ruby_version}"

    sudo "gem install bundler --no-rdoc --no-ri"
  end
  after "deploy:install", "ruby:install"
end