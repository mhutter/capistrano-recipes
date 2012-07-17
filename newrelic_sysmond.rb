# -*- encoding : utf-8 -*-
namespace :newrelic_sysmond do
  desc "Set up New Relic Sysmond"
  task :setup, roles: :web do
    run "#{sudo} wget -q -O /etc/apt/sources.list.d/newrelic.list http://download.newrelic.com/debian/newrelic.list"
    run "#{sudo} apt-key adv --keyserver hkp://subkeys.pgp.net --recv-keys 548C16BF"
    run "#{sudo} apt-get -qq update"
    run "#{sudo} apt-get -yq install newrelic-sysmond"
    run "#{sudo} nrsysmond-config --set license_key=#{newrelic_key}"
    run "#{sudo} service newrelic-sysmond start"
  end
  after "deploy:setup", "newrelic_sysmond:setup"
end
