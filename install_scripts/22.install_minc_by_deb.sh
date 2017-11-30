#!/bin/bash
curl -L --retry 6 -o temp.deb http://packages.bic.mni.mcgill.ca/minc-toolkit/Debian/minc-toolkit-1.9.15-20170529-Ubuntu_16.04-x86_64.deb
dpkg --install temp.deb
rm temp.deb

D_DIR=/opt/minc/1.9.15

if [ -e $HOME/.profile ]; then #ubuntu
	PROFILE=$HOME/.profile
elif [ -e $HOME/.bash_profile ]; then #centos
	PROFILE=$HOME/.bash_profile
else
	echo "Add PATH manualy: PATH=$D_DIR/bin"
	exit 0
fi

#check if PATH already exist in $PROFILE
if grep -xq "export PATH=$D_DIR/bin:\$PATH" $PROFILE #return 0 if exist
then 
	echo "PATH=$D_DIR/bin" in the PATH already.
else
	echo "" >>$PROFILE
    echo "#minc" >>$PROFILE
	echo "export PATH=$D_DIR/bin:\$PATH" >> $PROFILE
	echo "LD_LIBRARY_PATH=$D_DIR/lib:\$LD_LIBRARY_PATH" >> $PROFILE
    echo "source $D_DIR/minc-toolkit-config.sh" >>$PROFILE
fi

#test installation
source $PROFILE

#test installation
mincinfo -h >/dev/null
if [ $? -eq 1 ]; then #note itksnap return 1 when itksnap -h 
	echo "SUCCESS"
	echo "To update PATH of current terminal: source $PROFILE"
	echo "To update PATH of all terminal: re-login"
else
    echo 'FAIL.'
fi

