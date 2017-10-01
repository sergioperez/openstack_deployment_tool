OpenStack Cloud Deployment Tool

This is a proof-of-concept tool that I made as the work for my Bachelor Thesis

It has been designed in order to deploy OpenStack Mitaka at Ubuntu 14.04, but some decissions were taken in order to make it adaptable to different operating systems.

In order to create this tool the official OpenStack guide has been followed, trying to automatize the procedures automatic using scripts.
http://docs.openstack.org/mitaka/install-guide-ubuntu/

How it works:
This deployer is designed as a SaaS OpenStack deployer. It has two parts, the deployment server, which uses websocketd to receive a JSON message with the data required to deploy the cloud, and in the other hand, the deployer client, which is just a more or less simple webpage which builds this message. However, being it designed like that will make it possible to create any type of client.

How to use it:
1. Run the bash script "build_release.sh". It will create a file release1.tar.gz which the deployment service will need.
2. Run the bash script "run.sh" at the deployer_service folder. It will copy the release1.tar.gz file and then it will run the deployment server at the 8080 port.
3. The client will be accessible using the web server that websocketd will be running, but at the same time it will be at the "html" folder, being it the file "deployer_client.html". Open it and fill the data of your servers.


Project structure:
./deployer_service:
Deployment server.

./deployer_service/deploy
Scripts used by the deployment server to send the bash scripts to each one of the nodes.

./scripts:
Small scripts done to perform each one of the small parts that are shown at the OpenStack deployment guide.
Example:
./scripts/os/ubuntu1404/packages/install_package.sh - Receives as argument the name of a package and installs it.

Each one of the subfolders of scripts contain scripts strongly related with the service or component named at the folder.


./webscripts:
Each one of the webscripts subfolders contains a small number of bash scripts which call the scripts contained at the scripts folder



./documents
Documents delivered as the report and the slides of the Bachelor Thesis

Warning:
	There is still a bug which will not make Neutron work due to the configuration of the second interface


