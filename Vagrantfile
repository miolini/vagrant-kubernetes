IMAGE_NAME = "ubuntu/bionic64"
N = 3

Vagrant.configure("2") do |config|
    config.ssh.insert_key = false

    config.vm.provider "virtualbox" do |v|
        v.memory = 1024
        v.cpus = 2
    end

    config.vm.define "master" do |master|
        master.vm.box = IMAGE_NAME
        master.vm.network "private_network", ip: "192.168.50.10"
        master.vm.hostname = "master"
        master.vm.provision "base", type: "shell" do |s|
            s.path = "setup-base.sh"
            s.args = "192.168.50.10"
        end
        master.vm.provision "master", type: "shell" do |s|
            s.path = "setup-master.sh"
        end
    end

    (1..N).each do |i|
        config.vm.define "node-#{i}" do |node|
            node.vm.box = IMAGE_NAME
            node.vm.network "private_network", ip: "192.168.50.#{i + 10}"
            node.vm.hostname = "node-#{i}"
            node.vm.provision "shell" do |s|
                s.path = "setup-base.sh"
                s.args = "192.168.50.#{i + 10}"
            end
            node.vm.provision "shell" do |s|
                s.path = "setup-node.sh"
                s.args = "192.168.50.#{i + 10}"
            end
        end
    end
end