#!/bin/bash --login  

#Create a folder to install Nanofilt
mkdir /mnt/home/vascokar/Nanofilt

#Create a virtual environment with virtualenv
cd /mnt/home/vascokar/Nanofilt
virtualenv env
source env/bin/activate

#Install deeparg with pip and download the data required by deeparg
pip install nanofilt --upgrade

#To re-activate the virtual environment:
source env/bin/activate

#To deactivate
deactivate
