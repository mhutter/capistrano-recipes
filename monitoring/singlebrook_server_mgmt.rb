namespace :singlebrook_server_mgmt do
  desc "Add this machine to Singlebrook's Server Management service"
  task :install do
    apt_install 'landscape-client'
    sudo "landscape-config --computer-title `hostname` --account-name singlebrook-technology --silent" do |ch, stream, out|
      puts out
    end
  end
  after "deploy:install", "singlebrook_server_mgmt:install"
end
