Vagrant.configure("2") do |config|

  web_private_ip = ENV['WEB_PRIVATE_IP'] || "192.168.56.10"
  db_private_ip  = ENV['DB_PRIVATE_IP']  || "192.168.56.20"
  db_host_port   = (ENV['DB_HOST_PORT'] || "3307").to_i
  web_box = ENV['WEB_BOX'] || "ubuntu/jammy64"
  db_box  = ENV['DB_BOX']  || "centos/stream9" 


  config.vm.define "web-server" do |web|
    web.vm.box = web_box
    web.vm.hostname = "web-server"
    # public network (DHCP)
    web.vm.network "public_network"
    # private (host-only)
    web.vm.network "private_network", ip: web_private_ip
    # synced folder
    web.vm.synced_folder "./website", "/var/www/html"

    web.vm.network "forwarded_port", guest: 80, host: 8080

    web.vm.provider "virtualbox" do |vb|
      vb.name = "web-server-1"
      vb.memory = 1024
      vb.cpus = 1
    end

    web.vm.provision "shell", path: "scripts/provision-web-ubuntu.sh"
  end


  config.vm.define "db-server" do |db|
    db.vm.box = db_box
    db.vm.hostname = "db-server"
    db.vm.network "private_network", ip: db_private_ip

    db.vm.network "forwarded_port", guest: 3306, host: db_host_port, host_ip: "127.0.0.1"
    db.vm.synced_folder "./database", "/vagrant_database", type: "rsync"

    db.vm.provider "virtualbox" do |vb|
      vb.name = "db-server"
      vb.memory = 1024
      vb.cpus = 1
    end

    db.vm.provision "shell", path: "scripts/provision-db-centos.sh"
  end
end
