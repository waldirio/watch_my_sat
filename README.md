# WatchMySat

- On Satellite Server configure a password to the postgres user to connect via localhost
```
echo "alter user postgres with password 'password';" | su - postgres -c psql
```

- Some pre requirements on the Monitoring server (RHEL machine)
```
subscription-manager repos --enable rhel-7-server-ansible-2-rpms
subscription-manager repos --enable rhel-7-server-extras-rpms
yum install git -y
yum install ansible -y
yum install docker -y
curl -L https://github.com/docker/compose/releases/download/1.24.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
systemctl enable docker
systemctl start docker
setenforce 0
sed -i 's/^SELINUX=enforcing/SELINUX=permissive/g' /etc/selinux/config
```
Note. At this moment, will be necessary to change SELINUX to permissive.

- Let's create the Monitoring user
```
useradd monitor
groupadd docker
gpasswd -a monitor docker
systemctl restart docker
```

- Cloning the WatchMySat Project to the monitoring machine
```
# su - monitor
$ git clone https://github.com/waldirio/watch_my_sat.git
$ cd watch_my_sat
```

- Configuring the `postgres_exporter_password` at `watch_my_sat.variables`
```
postgres_exporter_password: password
```

- Configuring the `satellite_server` at `watch_my_sat.variables`
```
satellite_server: SAT_FQDN_HERE
```

- Configuring the `inventory` file
```
$ cat inventory 
[satellite]
SAT_FQDN_HERE
```

- Runnining the playbook ping to test the connection
```
$ ansible-playbook ping.yml
```
If fail, please generate the ssh key using the command `$ ssh-keygen` and then copy to the server `$ ssh-copy-id root@SAT_FQDN_HERE`. Rerun the command `$ ansible-playbook ping.yml` to confirm that everything is ok.

- Running the playbook to prepare the environment
```
$ ansible-playbook prepare.yml
```

- Starting the suite
```
cd scripts
./watchmysat start
```

- Stopping the suite
```
cd scripts
./watchmysat stop
```

- Checking the current status
```
cd scripts
./watchmysat status
```

- To Backup All the Historical Information (as root)
```
tar cvf watch_my_sat_data_bck.tar /var/lib/docker/volumes/watch_my_sat_*
```

- To Restore All the Historical Information (as root)
```
tar xvf watch_my_sat_data_bck.tar -C /
```
