#!/bin/bash
set -x
exec > >(tee /var/log/user-data.log|logger -t user-data ) 2>&1

mkdir /usr/puppetconfiguration
cd /usr/puppetconfiguration
apt-get update -y
apt-get install git-core -y
git clone https://github.com/rorychatt/Streamco-AppServer.git

# Change permissions of the directory
# chmod -R ug+rw Streamco-AppServer

chmod -R 777 Streamco-AppServer/puppet # CHANGE ASAP - Issue with running puppet librarian when you aren't su
./Streamco-AppServer/puppet/scripts/puppet.sh

# Get Puppet Repos for 14.04
wget -O /tmp/puppet.deb http://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb
dpkg -i /tmp/puppet.deb

# Install Puppet
apt-get update
apt-get install puppet-agent git-core ruby -y
gem install librarian-puppet
export PATH=$PATH:/opt/puppetlabs/bin/

# Remote Temporary files
rm /tmp/puppet.deb

#Install puppet dependancies
cd /usr/puppetconfiguration/Streamco-AppServer/puppet/
HOME=/root librarian-puppet install --verbose

# Run puppet apply
/opt/puppetlabs/bin/puppet apply /usr/puppetconfiguration/Streamco-AppServer/puppet/manifests/base.pp --debug \
  --verbose --summarize --reports store \
  --hiera_config=/usr/puppetconfiguration/Streamco-AppServer/puppet/hiera.yaml \
  --modulepath=/usr/puppetconfiguration/Streamco-AppServer/puppet/vendor/modules

# workaround for docker-compose failing to launch in puppet as non-sudo in user-data
cd /usr/puppetconfiguration/Streamco-AppServer/docker/
docker-compose up
