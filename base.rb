# -*- encoding : utf-8 -*-

# Change this if making a branch for a new Ubuntu
set :ubuntu_release_codename, 'precise'

# Helper Methods
def apt_install(packages, options = {})
  sudo "#{apt_install_command} #{packages}", options
end

def put_as_root(data, path, options = {})
  # Work around the sftp-doesn't-sudo issue
  sudo "touch #{path}"
  sudo "chown #{user} #{path}"
  put data, path, options
  sudo "chown root #{path}"
end

def template(from, to)
  erb = File.read(File.expand_path("../templates/#{from}", __FILE__))
  put ERB.new(erb).result(binding), to
end

def set_default(name, *args, &block)
  set(name, *args, &block) unless exists?(name)
end

# More defaults
set_default :apt_install_command, "DEBIAN_FRONTEND=noninteractive apt-get -yq install"

# Cap Tasks
namespace :deploy do
  desc "Set Up the server"
  task :install do
    sudo "apt-get -qq update"
    apt_install 'python-software-properties'
  end
end
