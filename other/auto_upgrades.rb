namespace :auto_upgrades do
  desc "Set up automatic upgrades of software packages"
  task :install do
    apt_install 'unattended-upgrades mailutils'
    # Per https://help.ubuntu.com/community/AutomaticSecurityUpdates
    put_as_root '  APT::Periodic::Update-Package-Lists "1";
                   APT::Periodic::Unattended-Upgrade "1";
                 '.gsub(/^ +/, ''),
                 '/etc/apt/apt.conf.d/20auto-upgrades'
    put_as_root '  // Automatically upgrade packages from these (origin, archive) pairs
                   Unattended-Upgrade::Allowed-Origins {
                     "${distro_id} ${distro_codename}";
                     "${distro_id} ${distro_codename}-security";
                     "${distro_id} ${distro_codename}-updates";
                   };
                   Unattended-Upgrade::Mail "root@localhost";
                   Unattended-Upgrade::Automatic-Reboot "true";
                 '.gsub(/^ +/, ''),
                 '/etc/apt/apt.conf.d/50unattended-upgrades'
  end
  after "deploy:install", "auto_upgrades:install"
end
