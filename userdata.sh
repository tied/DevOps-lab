#!/bin/bash

mkdir /usr/puppetconfiguration
cd /usr/puppetconfiguration
apt-get update
apt-get install git-core
git clone https://github.com/rorychatt/Streamco-AppServer.git
