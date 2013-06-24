namespace :logrotate_rails do
  desc "Rotate Rails log files"
  task :install, :roles => :app do
    apt_install 'logrotate'
    put_as_root logrotate_rails_conf, '/etc/logrotate.d/rails'
  end
  after "deploy:install", "logrotate_rails:install"

  def logrotate_rails_conf
    "/srv/www/*/shared/log/*.log {
      size=500M
      missingok
      rotate 26
      compress
      delaycompress
      notifempty
      copytruncate
    }".gsub(/^\s{4}/, '')
  end
end
