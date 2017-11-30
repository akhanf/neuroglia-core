#!/bin/bash

if [ "$#" -lt 1 ];then
	echo "Usage: $0 <install folder (absolute path)>"
	echo "For sudoer recommend: $0 /opt"
	echo "For normal user recommend: $0 $HOME/app"
	exit 0
fi

echo -n "installing heudiconv..." #-n without newline

DEST=$1
mkdir -p $DEST

D_DIR=$DEST/heudiconv
if [ -d $D_DIR ]; then
	rm -rf $D_DIR
fi

#get github version:
cd $DEST
#git clone https://github.com/nipy/heudiconv
git clone https://github.com/akhanf/heudiconv.git  # my fork fixes the phasediff bug
cd heudiconv
python setup.py install
cd

