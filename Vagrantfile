Vagrant.configure("2") do |config|

  config.vm.box = "dduportal/boot2docker"
  config.vm.synced_folder ".", "/vagrant", type: "rsync"

  config.vm.provision :docker do |d|

    #https://github.com/digibib/aptly-docker
    d.build_image "/vagrant/latest",
      args: "-t digibib/aptly"
  end

  config.vm.provision :docker do |d|
    d.run "digibib/aptly",
      args: "-p 8080:8080 \
            -v /vagrant/aptly:/aptly"
  end
end
