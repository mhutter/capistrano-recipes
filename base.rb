def template(from, to)
  erb = File.read(File.expand_path("../templates/#{from}", __FILE__))
  put ERB.new(erb).result(binding), to
end

def set_default(name, *args, &block)
  set(name, *args, &block) unless exists?(name)
end

namespace :deploy do
  desc "Set Up the server"
  task :install do
    run "#{sudo} apt-get -qq update"
    run "#{sudo} apt-get -yq install python-software-properties"
  end
end
