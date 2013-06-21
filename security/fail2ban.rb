# -*- encoding : utf-8 -*-
namespace :fail2ban do
  desc "Install fail2ban from package manager and set it up to work with ufw firewall"
  task :install do
    apt_install 'fail2ban'

    put_as_root jail_local_config, '/etc/fail2ban/jail.local'
    put_as_root ufw_config, '/etc/fail2ban/action.d/ufw-ssh.conf'
    restart
  end
  after 'deploy:install', 'fail2ban:install'

  %w{start stop restart}.each do |command|
    desc "#{command} fail2ban"
    task command do
      sudo "service fail2ban #{command}"
    end
  end

  def jail_local_config
    jail_local =<<-EOF
      [ssh]
      enabled = true
      banaction = ufw-ssh
      filter = sshd
      logpath = /var/log/auth.log
      maxretry = 3
    EOF
    jail_local.gsub(/^\s+/, '')
  end

  def ufw_config
    ufw =<<-EOF
      [Definition]
      actionstart =
      actionstop =
      actioncheck =
      actionban = ufw insert 1 deny from <ip> to any app OpenSSH
      actionunban = ufw delete deny from <ip> to any app OpenSSH
    EOF
    ufw.gsub(/^\s+/, '')
  end
end
