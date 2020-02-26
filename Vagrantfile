Vagrant.configure("2") do |config|
  config.vm.define "foolishness-dev" do |foolishness|
    foolishness.vm.box = "bento/ubuntu-16.04"    
    foolishness.vm.network "private_network", ip: "192.168.50.100"
    foolishness.vm.provision :shell, path: "vagrant.sh"
    foolishness.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.cpus = "2"
      vb.name = "foolishness"
    end
  end
end