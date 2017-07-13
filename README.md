Ansible for postgres

This script allows you to launch an instance on Amazon-EC2. Running the script launches an instance and automatically installs Postgres allowing access to db and ssh .

Before You Start

Create an Amazon EC2 keypair for yourself. Make sure that you set the permissions for the private key file to 600 (i.e. only you can read and write it) so that ssh will work.
Whenever you want to use this script , set the environment variables AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY to your Amazon EC2 access key ID and secret access key. These can be obtained from the AWS homepage by clicking Account > Security Credentials > Access Credentials.
Launching An Instance

Git clone this repository into your local machine
Export the environment variables from your machine before you run the script.
For example:

export AWS_SECRET_ACCESS_KEY= AaBcDeFg

export AWS_ACCESS_KEY_ID= abcd123

Running the script

Make sure Ansible is installed in your system and initially git clone this repository.

Git clone gives you three different files:

site.yml -[ Ansible playbook which launches instance on AWS ]
vars.yml -[ Has your environmen variables used for connecting to AWS ]
delete_script.sh -[ Checks if any mount points are >90% full, free memory is <5% and alerts through email ]
Making sure the above necessary steps are followed, run the command :

$ ansible-playbook site.yml

How does the script work

Initially , tasks parses the environment variables from vars.yml
Creates security group under ec2 which allows access to following:
Port 22 ( ssh )
Port 80 ( db )
Port 5432 ( postgres )
Launches Instance parsing in the environment variables from vars.yml ; accepts the key pair, assigns public_IP and allots the region to itself.
Instance is added to host group where public_IP and group name= data base is taken.
Parsing database as host and user=ubuntu, postgres is automatically installed with the code written.
Script for monitoring mounts

Before running the script :

Chane the email for alert notifications.
Set the path of your script to run the cron job .
Scipt checks the disk space and if the memory is greater than 90% full.
Checks if free memory is less than 5% of total memory.
If the conditions are met , it alerts a mail to mentioned email.
Also , cron job is set for every 5 minutes.

Setting up VPN

Install openvpn client locally and following commands should be run after ssh'ing to the instance .
Followed by the commands , after installation edit the openvpn key file and add the port and proto tcp client details ( mentioned in file )
Ensure you have opened ports for 1194 similar to the one like port 80, 5432, etc
ssh to 10.4.0.2 and see if the ip is open
