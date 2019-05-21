#!/bin/bash

# pip3
curl https://bootstrap.pypa.io/get-pip.py | python3 

# datalad-osf
if [ -e /tmp/datalad-osf ]
then
    rm -rf /tmp/datalad-osf
fi 

git clone https://github.com/khanlab/datalad-osf /tmp/datalad-osf && cd /tmp/datalad-osf
sudo pip3 install -r requirements.txt && sudo python3 setup.py install && cd 
