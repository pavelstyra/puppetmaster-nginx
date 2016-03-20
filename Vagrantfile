require './vagrant-provision-reboot-plugin'
Vagrant.configure(2) do |config|

  config.vm.define "master" do |master|
    master.vm.hostname = "puppetmaster"
    master.vm.box = "box-cutter/centos67"
    master.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.cpus = "1"
      end
    master.vm.provision "shell", path: "provision-vb-01.sh"
    master.vm.provision :unix_reboot
    master.vm.provision "shell", path: "provision-vb-02.sh"
    #master.vm.provision :puppet do |puppet|
    #  puppet.module_path = "modules"
    #  puppet.manifests_path = "manifests"
    #  puppet.manifest_file = "master.pp"
    #end
  end

end
