# Server install tasks. Run with:
# cap [level] deploy:install -s user=[sudoer_user]
# sudoer_user must have passwordless sudo available.

# Required for all Singlebrook-managed servers
load 'config/install/recipes/base'
load 'config/install/recipes/security/firewall'
load 'config/install/recipes/security/fail2ban'
load 'config/install/recipes/mail/postfix'
load 'config/install/recipes/mail/root_forwarding'
load 'config/install/recipes/other/auto_upgrades'

# Most servers will want these
load 'config/install/recipes/security/deploy_user'
load 'config/install/recipes/scm/git'

# Various services
load 'config/install/recipes/webserver/apache2'
load 'config/install/recipes/database/mysql'
load 'config/install/recipes/database/postgresql'
load 'config/install/recipes/other/memcached'

# PHP stuff
load 'config/install/recipes/language/php'

# Rails stuff
load 'config/install/recipes/log/logrotate_rails'
set :ruby_version, 'ruby1.8'
load 'config/install/recipes/language/ruby'
# Things that depend on Ruby
load 'config/install/recipes/appserver/passenger'
load 'config/install/recipes/other/gem_deps'