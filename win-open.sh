#!/bin/bash
if [ -z $1 ]
then
	linux_dir=.
else
	linux_dir=$1
fi

windows_dir=`wslpath  -w ${linux_dir}`
/mnt/c/Windows/explorer.exe ${windows_dir}
