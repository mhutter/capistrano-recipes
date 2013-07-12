namespace :rackspace_cloud_backup do
  desc "Install Rackspace Cloud Monitoring Agent"
  task :install do
    set :rackspace_username, Capistrano::CLI.ui.ask("Rackspace username?")  unless exists?(:rackspace_username)
    set :rackspace_api_key, Capistrano::CLI.ui.ask("Rackspace API key?") unless exists?(:rackspace_api_key)

    sudo 'curl -s http://agentrepo.drivesrvr.com/debian/agentrepo.key | sudo apt-key add -'

    put_as_root "deb [arch=amd64] http://agentrepo.drivesrvr.com/debian/ serveragent main",
                '/etc/apt/sources.list.d/driveclient.list'
    sudo 'apt-get -qq update'
    apt_install 'driveclient'

    # driveclient's output doesn't work with capistrano's interactivity features.
    # Piping a stream of "n"s into it allows us to respond to
    # any "Agent already configured. Overwrite?" prompts.
    run "yes | sed s/y/n/ | sudo driveclient --configure --username #{rackspace_username} --apikey #{rackspace_api_key}"
    sudo "service driveclient start"
  end
  after "deploy:install", "rackspace_cloud_backup:install"
end
