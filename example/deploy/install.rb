# Server install tasks. Run with:
# cap [level] deploy:install -s user=[sudoer_user]
# sudoer_user must have passwordless sudo available.
load 'config/install/recipes/base'
load 'config/install/recipes/security/firewall'
load 'config/install/recipes/security/fail2ban'
load 'config/install/recipes/security/deploy_user'
load 'config/install/recipes/scm/git'
load 'config/install/recipes/webserver/apache2'
load 'config/install/recipes/database/mysql'
load 'config/install/recipes/database/postgresql'
load 'config/install/recipes/other/memcached'
load 'config/install/recipes/log/logrotate_rails'
load 'config/install/recipes/mail/postfix'

set :ruby_version, 'ruby1.8'
load 'config/install/recipes/language/ruby'

# Things that depend on Ruby should go down here
load 'config/install/recipes/appserver/passenger'
load 'config/install/recipes/other/gem_deps'