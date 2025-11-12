Vagrant.configure("2") do |config|
  config.vm.box = "${box}"
  
  config.vm.define "${vm_name}" do |node|
    node.vm.hostname = "${hostname}"
    node.vm.network "private_network", ip: "${ip}", virtualbox__intnet: false, name: "VirtualBox Host-Only Ethernet Adapter"
    
    node.vm.provider "virtualbox" do |vb|
      vb.name = "${vm_name}"
      vb.memory = "${memory}"
      vb.cpus = ${cpus}
    end

    # Enable SSH password authentication
    node.vm.provision "shell", inline: <<-SHELL
      sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
      sudo systemctl restart sshd
    SHELL
  end
end