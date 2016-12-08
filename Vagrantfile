# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "centos7"
  config.vm.box_url = "centos7.box"
  config.vm.synced_folder ".", "/vagrant", id: "vagrant-root", disabled: true
  config.vm.hostname = "nwa"
#  config.vm.network "private_network", ip: "172.28.128.153"
  config.vm.network "forwarded_port", guest: 9119, host: 9119   # nagios
  config.vm.network "forwarded_port", guest: 1337, host: 1337   # app
  config.ssh.insert_key = false 
  config.vm.provision "ansible" do |ansible|
   ansible.config_file = "./ansible/ansible.cfg"
   ansible.playbook = "./ansible/site.yml"
   ansible.inventory_path = "./ansible/hosts"
   ansible.limit = "all"
#  ansible.verbose = "vvvv"
  end  

end
