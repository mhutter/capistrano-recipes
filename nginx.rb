# -*- encoding : utf-8 -*-
set_default(:ipv6, true)

namespace :nginx do
  desc "Install latest stable release of nginx"
  task :install, roles: :web do
    run "#{sudo} add-apt-repository -y ppa:nginx/stable"
    run "#{sudo} apt-get -qq update"
    run "#{sudo} apt-get -yq install nginx"

    template "nginx_listen.conf.erb", "/tmp/listen.conf"
    run "#{sudo} mv /tmp/listen.conf /etc/nginx/conf.d/listen.conf"
    run "#{sudo} rm -f /etc/nginx/sites-enabled/default"
    restart
  end
  after "deploy:install", "nginx:install"

  desc "Setup nginx config for this app"
  task :setup, roles: :web do
    template "nginx_unicorn.erb", "/tmp/nginx_conf"
    run "#{sudo} mv /tmp/nginx_conf /etc/nginx/sites-enabled/#{application}"
    restart
  end
  after "deploy:setup", "nginx:setup"

  %w{start stop restart}.each do |command|
    desc "#{command} nginx"
    task command, roles: :web do
      run "#{sudo} service nginx #{command}"
    end
  end
end
