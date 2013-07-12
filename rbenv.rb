# -*- encoding : utf-8 -*-
set_default :ruby_version, "2.0.0-p247"
set_default :use_rmagick, false
set_default :use_rbenv_gemset, false

namespace :rbenv do
  desc "Install rbenv, Ruby prequisites, Ruby and the Bundler gem"
  task :install, roles: :app do
    # install prequisites
    run "#{sudo} apt-get -qq update"
    ruby_deps = "g++ gcc make libc6-dev patch openssl ca-certificates libreadline6 \
        libreadline6-dev curl zlib1g zlib1g-dev libssl-dev libyaml-dev \
        libsqlite3-dev sqlite3 autoconf \
        libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev"
    rmagick_deps = "imagemagick libmagickcore-dev libmagickwand-dev" if use_rmagick
    run "#{sudo} apt-get -yq install git-core #{ruby_deps} #{rmagick_deps}"

    # install rbenv and plugins
    run "git clone -q https://github.com/sstephenson/rbenv.git ~/.rbenv"
    run "mkdir -p ~/.rbenv/plugins"
    run "git clone -q https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build"

    if use_rbenv_gemset
      run "git clone -q https://github.com/jamis/rbenv-gemset.git ~/.rbenv/plugins/rbenv-gemset"
      put "global", "/home/#{user}/.rbenv-gemsets"
    end

    # do the bashrc-fu
    bashrc = <<-BASHRC
if [ -d ${HOME}/.rbenv ]; then
  export PATH="${HOME}/.rbenv/bin:${PATH}"
  eval "$(rbenv init -)"
fi
BASHRC
    put bashrc, "/tmp/rbenvrc"
    run "cat ~/.bashrc /tmp/rbenvrc > ~/.bashrc.tmp"
    run "mv ~/.bashrc.tmp ~/.bashrc"

    # install ruby
    run %q[export PATH="${HOME}/.rbenv/bin:${PATH}"]
    run %q[eval "$(rbenv init -)"]
    run "rbenv install #{ruby_version}"
    run "rbenv global #{ruby_version}"
    run "gem install bundler --no-ri --no-rdoc"
    run "rbenv rehash"
  end
  after "deploy:install", "rbenv:install"
end
