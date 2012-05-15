set_default :ruby_version, "1.9.3-p194"
set_default :use_rmagick, false
set_default :use_rbenv_gemset, true

namespace :rbenv do
  desc "Install rbenv, Ruby prequisites, Ruby and the Bundler gem"
  task :install, roles: :app do
    # install prequisites
    run "#{sudo} apt-get -qq update"
    run "#{sudo} apt-get -y install curl git-core build-essential zlib1g-dev openssl libssl-dev libreadline-dev"
    if use_rmagick
      run "#{sudo} apt-get -y install imagemagick libmagickcore-dev libmagickwand-dev"
    end
    # install rbenv and plugins
    run "git clone -q https://github.com/sstephenson/rbenv.git ~/.rbenv"
    run "mkdir -p ~/.rbenv/plugins"
    run "git clone -q https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build"
    if use_rbenv_gemset
      run "git clone -q https://github.com/jamis/rbenv-gemset.git ~/.rbenv/plugins/rbenv-gemset"
    end
    put "global", "/home/#{user}/.rbenv-gemsets"
    # do the bashrc-fu
    bashrc = <<-BASHRC
if [ -d ${HOME}/.rbenv ]; then
  export PATH="${HOME}/.rbenv/bin:${PATH}"
  eval "$(rbenv init -)"
fi
BASHRC
    put bashrc, "/tmp/rbenvrc"
    run "cat /tmp/rbenvrc ~/.bashrc > ~/.bashrc.tmp"
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
