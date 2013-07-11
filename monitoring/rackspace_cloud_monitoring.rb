namespace :rackspace_cloud_monitoring do
  desc "Install Rackspace Cloud Monitoring Agent"
  task :install do
    set :rackspace_username, Capistrano::CLI.ui.ask("Rackspace username?")  unless exists?(:rackspace_username)
    set :rackspace_api_key, Capistrano::CLI.ui.ask("Rackspace API key?") unless exists?(:rackspace_api_key)

    put_as_root "deb http://stable.packages.cloudmonitoring.rackspace.com/ubuntu-12.04-x86_64 cloudmonitoring main",
                '/etc/apt/sources.list.d/rackspace-monitoring-agent.list'
    sudo 'curl -s https://monitoring.api.rackspacecloud.com/pki/agent/linux.asc | sudo apt-key add -'
    sudo 'apt-get -qq update'
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
