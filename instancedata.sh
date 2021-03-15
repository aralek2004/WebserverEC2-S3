#!/bin/bash

#Creates a file called metadata.txt 

touch metadata.txt

#Retrieves and stores the hostname, iam info, security groups in the metadata.txt 
curl -w "\n" http://169.254.169.254/latest/meta-data/hostname > metadata.txt


curl -w "\n"  http://169.254.169.254/latest/meta-data/iam  >> metadata.txt


curl -w "\n"  http://169.254.169.254/latest/meta-data/security-groups >> metadata.txt
