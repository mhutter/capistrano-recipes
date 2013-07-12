# -*- encoding : utf-8 -*-
set_default(:procfile, "Procfile.prod")

namespace :foreman do
  desc "re-generate upstart scripts"
  task :export, roles: :app do
    foreman = "foreman export upstart /etc/init -a #{application} \
                 -l #{shared_path}/log -u #{user} -d #{current_path} \
                 -f #{current_path}/#{procfile}"
    run "cd #{current_path} && #{sudo} #{foreman}"
  end
  after "deploy:symlink", "foreman:export"
  # this is quite late, however we need the code to generate the scripts

  %w[start stop restart].each do |command|
    desc "#{command} the app server"
    task command, roles: :app do
      run "service #{application} #{command}"
    end
    after "deploy:#{command}", "foreman:#{command}"
  end
end
