set_default(:root_mail_recipient) { Capistrano::CLI.ui.ask "Who should receive root's mail? (An SB team address is a good option here): " }
namespace :root_forwarding do
  desc "Sets up forwarding of root's mail. This depends on postfix having been installed."
  task :install do
    sudo "echo 'root:\t#{root_mail_recipient}' | sudo tee -a /etc/aliases > /dev/null"
    sudo "newaliases"
  end
  after 'deploy:install', 'root_forwarding:install'
end