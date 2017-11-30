#!/bin/bash

#Install Node.js (at least version 4.4.4)
apt-get update
apt-get install -y nodejs
apt-get install -y npm
#From a terminal run npm install -g bids-validator
npm install -g bids-validator
ln -s /usr/bin/nodejs /usr/bin/node

