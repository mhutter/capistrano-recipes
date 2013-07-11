set :rackspace_username, Capistrano::CLI.ui.ask("Rackspace username?") if rackspace_username.nil?
set :rackspace_api_key, Capistrano::CLI.ui.ask("Rackspace API key?") if rackspace_api_key.nil?

namespace :rackspace_cloud_monitoring do
  desc "Install Rackspace Cloud Monitoring Agent"
  task :install do
    put_as_root "deb http://stable.packages.cloudmonitoring.rackspace.com/ubuntu-12.04-x86_64 cloudmonitoring main",
                '/etc/apt/sources.list.d/rackspace-monitoring-agent.list'
    #sudo 'curl -s https://monitoring.api.rackspacecloud.com/pki/agent/linux.asc | sudo apt-key add -'
    #sudo 'apt-get -qq update'
    apt_install 'rackspace-monitoring-agent'

    sudo "rackspace-monitoring-agent --setup"  do |ch, stream, out|
      puts out
      ch.send_data "#{rackspace_username}"+"\n" if out =~ /Username:/
      ch.send_data "#{rackspace_api_key}"+"\n" if out =~ /API Key or Password:/
      ch.send_data Capistrano::CLI.ui.ask("")+"\n" if out =~ /Select Option/
    end

    sudo "service rackspace-monitoring-agent start"
  end
  after "deploy:install", "rackspace_cloud_monitoring:install"
end
