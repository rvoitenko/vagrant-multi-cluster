# -*- mode: ruby -*-
# vi: set ft=ruby :

NODE_COUNT = 3

groups = {
  "webservers" => ["node[1:#{NODE_COUNT}]"]
}

Vagrant.configure(2) do |config|

config.vm.box = "ubuntu/trusty64"

config.vm.provider :virtualbox do |v|
   v.memory = 256
   v.cpus = 1
end

  # web nodes
  (1..NODE_COUNT).each do |i|
    node_id = "node#{i}"
    config.vm.define node_id do |node|
      node.vm.hostname = "#{node_id}"
      node_ip = "192.168.50.1#{i}"
      node.vm.network "private_network", ip: "#{node_ip}"
      node.vm.provision "ansible" do |ansible|
        ansible.playbook = "provisioning/webnode.yml"
      end
      node.vm.provider "virtualbox" do |node|
        node.name = "#{node_id}"
      end
    end
  end

  # load balancer VM
  config.vm.define "lb" do |lb|
    lb_ip = "192.168.50.10"
    lb.vm.hostname = "lb"
    lb.vm.network "private_network", ip: "#{lb_ip}"
    lb.vm.provision "ansible" do |ansible|
      ansible.playbook = "provisioning/balancer.yml"
      ansible.groups = groups
    end
    lb.vm.provider "virtualbox" do |lb|
      lb.name = "lb"
    end
    lb.vm.provision "shell" do |s|
      s.privileged = false
      s.inline = "echo Balancer url is http://#{lb_ip}"
      s.inline = "echo Balancer status url is http://#{lb_ip}/status"
    end
  end


end
