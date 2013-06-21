# -*- encoding : utf-8 -*-
# Helper Methods
def apt_install(*args)
  run "#{apt_install_command} #{args.join(' ')}"
end

def template(from, to)
  erb = File.read(File.expand_path("../templates/#{from}", __FILE__))
  put ERB.new(erb).result(binding), to
end

def set_default(name, *args, &block)
  set(name, *args, &block) unless exists?(name)
end
# More defaults
set_default(:lsb_release) { capture "lsb_release -r | cut -f 2" }
set_default :apt_install_command, "#{sudo} DEBIAN_FRONTEND=noninteractive apt-get -yq install"

# Cap Tasks
namespace :deploy do
  desc "Set Up the server"
  task :install do
    run "#{sudo} apt-get -qq update"
    apt_install 'python-software-properties'
  end
end
