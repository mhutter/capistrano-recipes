# -*- encoding : utf-8 -*-
namespace :newrelic_sysmond do
  desc "Set up New Relic Sysmond"
  task :setup, :roles => :web do
    sudo "wget -q -O /etc/apt/sources.list.d/newrelic.list http://download.newrelic.com/debian/newrelic.list"
    sudo "apt-key adv --keyserver hkp://subkeys.pgp.net --recv-keys 548C16BF"
    sudo "apt-get -qq update"
    sudo "apt-get -yq install newrelic-sysmond"
    sudo "nrsysmond-config --set license_key=#{newrelic_key}"
    sudo "service newrelic-sysmond start"
  end
  after "deploy:setup", "newrelic_sysmond:setup"
end
