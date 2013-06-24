# Server install tasks. Run with:
# cap [level] deploy:install -s user=[sudoer_user]
# sudoer_user must have passwordless sudo available.
load 'config/deploy/recipes/base'
load 'config/deploy/recipes/security/firewall'
load 'config/deploy/recipes/security/fail2ban'
load 'config/deploy/recipes/security/deploy_user'
load 'config/deploy/recipes/scm/git'
load 'config/deploy/recipes/webserver/apache2'
load 'config/deploy/recipes/database/mysql'
load 'config/deploy/recipes/database/postgresql'
load 'config/deploy/recipes/other/memcached'
load 'config/deploy/recipes/log/logrotate_rails'
load 'config/deploy/recipes/mail/postfix'

set :ruby_version, 'ruby1.8'
load 'config/deploy/recipes/language/ruby'
load 'config/deploy/recipes/appserver/passenger'
