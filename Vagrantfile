Vagrant.configure("2") do |config|
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.network "forwarded_port", guest: 80, host: 80
  config.vm.network "forwarded_port", guest: 3389, host: 3389  
  config.vm.network "public_network"
  config.vm.define "foolishness-vm" do |foolishness|
    foolishness.vm.box = "bento/ubuntu-16.04"    
    foolishness.vm.provision :shell, path: "vagrant.sh"
    foolishness.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.cpus = "2"
      vb.name = "foolishness"
    end
  end
end