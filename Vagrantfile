# -*- mode: ruby -*-
# vi: set ft=ruby :

chunks = [
    {
        :name => "chunk1",
        :eth1 => "192.168.2.211",
    },
    {
        :name => "chunk2",
        :eth1 => "192.168.2.212",
    },
    {
        :name => "chunk3",
        :eth1 => "192.168.2.213",
    },
    {
        :name => "chunk4",
        :eth1 => "192.168.2.214",
    },
    {
        :name => "chunk5",
        :eth1 => "192.168.2.215",
    },
]

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
  end
  config.vm.box = "https://github.com/tommy-muehle/puppet-vagrant-boxes/releases/download/1.1.0/centos-7.0-x86_64.box"

  config.vm.define "mfsmaster", primary: true do |mfsmaster|
    mfsmaster.persistent_storage.enabled = true
    mfsmaster.persistent_storage.location = "vdis/mfsmaster.vdi"
    mfsmaster.persistent_storage.size = 5000
    mfsmaster.persistent_storage.use_lvm = false
    mfsmaster.persistent_storage.mountname = 'mfs1'
    mfsmaster.persistent_storage.filesystem = 'xfs'
    mfsmaster.persistent_storage.mountpoint = '/mnt/sdb'
    mfsmaster.vm.hostname = "mfsmaster"
    mfsmaster.vm.network "private_network", bridge: 'eth1', ip: '192.168.2.200', :netmask => '255.255.255.0'

    mfsmaster.vm.provision :puppet do |puppet|
      puppet.manifests_path = "etc/manifests"
      puppet.module_path    = "etc/modules"
      puppet.manifest_file  = "test.pp"
      puppet.options        = "--debug --hiera_config=/vagrant/etc/manifests/hiera.yaml"
      puppet.facter         = { "vagrant" => "1" }
    end
  end
  config.vm.define "metalogger", primary: true do |metalogger|
    metalogger.persistent_storage.enabled    = true
    metalogger.persistent_storage.location   = "vdis/metalogger.vdi"
    metalogger.persistent_storage.size       = 5000
    metalogger.persistent_storage.use_lvm    = false
    metalogger.persistent_storage.mountname  = 'mfs1'
    metalogger.persistent_storage.filesystem = 'xfs'
    metalogger.persistent_storage.mountpoint = '/mnt/sdb'
    metalogger.vm.hostname = "metalogger"
    metalogger.vm.network "private_network", bridge: 'eth1', ip: '192.168.2.201', :netmask => '255.255.255.0'

    metalogger.vm.provision :puppet do |puppet|
      puppet.manifests_path = "etc/manifests"
      puppet.module_path    = "etc/modules"
      puppet.manifest_file  = "test.pp"
      puppet.options        = "--debug --hiera_config=/vagrant/etc/manifests/hiera.yaml"
      puppet.facter         = { "vagrant" => "1" }
    end
  end

    chunks.each do |opts|
      config.vm.define opts[:name] do |config|
        config.persistent_storage.enabled = true
        config.persistent_storage.location = "vdis/#{opts[:name]}.vdi"
        config.persistent_storage.size = 5000
        config.persistent_storage.use_lvm = false
        config.persistent_storage.mountname = 'mfs1'
        config.persistent_storage.filesystem = 'xfs'
        config.persistent_storage.mountpoint = '/mnt/sdb'
        config.vm.hostname = opts[:name]
        config.vm.network "private_network", bridge: 'eth1', ip: opts[:eth1], :netmask => '255.255.255.0'
        config.vm.provision :puppet do |puppet|
          puppet.manifests_path = "etc/manifests"
          puppet.module_path    = "etc/modules"
          puppet.manifest_file  = "test.pp"
          puppet.options        = "--debug --hiera_config=/vagrant/etc/manifests/hiera.yaml"
          puppet.facter         = { "vagrant" => "1" }
      end
    end
  end
end
