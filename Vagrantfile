Vagrant.configure("2") do |config|
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.network "public_network"
  config.vm.define "foolishness-vm" do |master|
    master.vm.box = "bento/ubuntu-16.04"    
    master.vm.provision :shell, path: "vagrant.sh"
    master.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.cpus = "2"
      vb.name = "foolishness"
    end
  end
end