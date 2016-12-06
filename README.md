## Home work
Status:

* Vagrant box created (CentOS 7), maybe some tuning still needed, but looks like working fine.
* Monitoring deployment using ansible - ready (Nagios core 4.2.1)
* Installed nginx for reverse proxy, sends traffic from 9119 to 8080. Uses self-signed SSL cert. nginx deploy and conf is added to Ansible.
* Application is installed (python module BaseHTTPServer) and listening on 1337 port.
* Nagios is configured to check application logfiles on two metrics: error message count, and access messages.
* Nginx reconfigured so http is redirected to https. Only issue I cannot get rid of is that "/" is required after non root path, for examle https://127.0.0.1:9119/nagios will not work, but https://127.0.0.1:9119/nagios/ will work correctly :S

Next:

* Ansible: looks like after deploy nginx or httpd or both are not restarted, also nagios service need restart imho - check if true still
* stress test - current idea is to write simple bash script which will use curl and nc for connecting to port.
* configure Vagrant file to use Asnible role
* configure Vagrant to forward different port than 2222, to ensure it is not busy already

## Deadline for submission: 13.12.2016

## Summary:

Set up an environment on a Vagrant box VM containing:
 * monitoring system 
 * web server 
 * simple application. 
Monitor one application parameter triggering an alert when this parameter exceeds a given threshold.


## Tasks:

 Prepare a Vagrant box with a minimal version of Linux installed.

 Provision the server using a configuration management tool and automate the whole setup as much as possible. All of this additional setup (packages, services, directories, settings, ...) should therefore be described as code.

 Write a simple application (e.g. JVM) that listens on a local port for HTTP requests. It should expose a single application metric for further monitoring (e.g. requests/per sec, load, connections count, etc.) that will grow when the application is put under load.

 Create an Ansible role, a Puppet module, a Chef recipe (or other encapsulation concept if other tool is used) for deploying and running your application.

 Set up basic monitoring system that monitors and keeps trends of basic server parameters (CPU, RAM, disk data).

 Set up a web server in reverse proxy mode forwarding requests to your application. Expose the port it listens on to the VM’s host machine, so that it will be accessible from it.

 Set up another virtual host for the web server to listen on another port. This virtualhost should serve the monitoring system’s web UI. Bonus points will be granted if you set up SSL for this port. Self-signed certificate will do. Expose this port to the host as well.

 Add monitoring to the application metric. Set up thresholds that would trigger an alarm in the monitoring system.

 Create a stress test for the application that would change the reported metric value when the test is launched.

## Deliverables:

*Plain text file with short and sane instructions of: 

a. how to run stress test 

b. how to access monitoring system - url, credentials, etc

*Vagrant project: 

a. should contain a working configuration, so that a simple "vagrant up" can be used to set up the project 

b. should contain all configuration management code that is required to set up environment 

c. should contain all the necessary extra files (if any)

## Technical requirements:

Use Linux distribution of your choice, but install minimal version of it

Use Puppet, Chef, Ansible or Salt as a configuration management tool

Use configuration management tool locally as for standalone host (without pulling configuration from server/master/etc)

Use Zabbix, Ganglia, Nagios or similar tool for monitoring

Monitoring system should only visually show alert in dashboard, no other action required.

All documentation, comments, etc should be written in English

#What gets evaluated
Tasks realisation according to the instructions and requirements

Configuration management tool usage

Code clarity and structure

Modern practices, standards and conventions observance

Documentation clarity

Project setup esasines

