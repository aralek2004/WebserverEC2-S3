#!/bin/bash


ACTION=${1}

VERSION="1.0.0"


function login_to_server () {

#Update all system packages
sudo yum update -y

#Install the Nginx software package
sudo amazon-linux-extras install nginx1.12 -y

#Configure nginx to automatically start at system boot up
sudo chkconfig nginx on

#Copy the website documents from s3 to the web document root directory
 sudo aws s3 cp s3://keji-assignment-webserver/index.html /usr/share/nginx/html/index.html

#sudo aws s3 cp s3://* /usr/share/nginx/html/index.html

#Start the Nginx service
sudo service nginx start


}



function uninstall_nginx () {
#Stop the Nginx service
sudo systemctl stop nginx

#Delete the files in the website document root directory
rm /usr/share/nginx/html/*

#Uninstall the Nginx software package 
sudo yum remove nginx -y

}

function show_version () {
echo "$VERSION"
}

function display_help () {

cat << EOF
usage: ${0} {-v|--version|-r|--remove|-h|--help}
OPTIONS:
	-v | --version  show version
	-r | --remove	uninstall nginx 
	-h | --help	Display the command help


EXamples:
	show version
		$ ${0} -v
	uninstall nginx
		$ ${0} -r
	Display help:
		$ ${0} -h
EOF
}


case "$ACTION" in
	-h|--help)
                display_help
               	;;
       	-r|--remove)
                uninstall_nginx
		;;
       	-v|--version)
               	show_version
               	;;
         *)
	login_to_server
        exit 1
esac

