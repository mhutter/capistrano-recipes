# -*- encoding : utf-8 -*-
set_default(:ipv6, true)
set_default(:shost_path) { File.expand_path("../static-#{application}", deploy_to) }

namespace :nginx do
  namespace :shost do

    desc "Setup nginx vHost for s.example.com"
    task :setup, :roles => :web do
      run "mkdir -p #{shost_path}"
      template "nginx_shost_404.html.erb", "#{shost_path}/404.html"
      template "nginx_shost.erb", "/tmp/nginx_shost"
      run "#{sudo} mv /tmp/nginx_shost /etc/nginx/sites-enabled/static-#{application}"
      nginx.restart
    end
    after "deploy:setup", "nginx:shost:setup"

  end
end
