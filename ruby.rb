# -*- encoding : utf-8 -*-
set_default :ruby_version, "ruby1.8"
set_default :use_rmagick, false
set_default :use_rbenv_gemset, true

# This uses Brightbox's Ruby packages for Ubuntu
namespace :ruby do
  desc "Install Ruby, Ruby prequisites, Ruby and the Bundler gem"
  task :install, :roles => :app do
    # install prerequisites
    apt_install 'curl git-core build-essential zlib1g-dev openssl libssl-dev libreadline-dev'
    if use_rmagick
      apt_install 'imagemagick libmagickcore-dev libmagickwand-dev'
    end
    run "#{sudo} apt-add-repository ppa:brightbox/ruby-ng"
    run "#{sudo} apt-get -qq update"
    apt_install 'ruby rubygems ruby-switch'
    run "#{sudo} ruby-switch --set #{ruby_version}"

    run "#{sudo} gem install bundler --no-rdoc --no-ri"
  end
  after "deploy:install", "ruby:install"
end
