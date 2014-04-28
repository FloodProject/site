Bootstrap
---------

If you have not yet setup a basic VM to bootstrap the project, please follow the guide in [Bootstrap.md].

We use some simple Lua scripts to build the containers with `docker`.

Stack
-----

LoadBalancer (TCP)
Router/Proxy (nginx/HAProxy/Hipache)
Web (nginx/php-fm)
Database (MariaDB)
JobQueue (Redis)
Cache (Redis)
Builder
Registry
Storage
Logger
Analytics

Deployment
----------

# Create containers
docker run -v /var/lib/mysql --name=db-data busybox true
docker run -d --volumes-from=db-data --name=db bnchdrff/mariadb
docker run -v /srv/www -v /etc/nginx/sites-enabled --name web-data busybox true
docker run -d -p 80:80 -p 2222:22 --link=db:db --volumes-from=web-data --name=web bnchdrff/nginx-php5-drupal

Resources
---------

http://12factor.net/

* vagrant-vbguest
A Vagrant plugin to keep your VirtualBox Guest Additions up to date
https://github.com/dotless-de/vagrant-vbguest

* Debian Vagrant
https://github.com/ffuenf/vagrant-boxes/tree/master/packer/debian-7.4.0-amd64

* CoreOS Vagrant
https://github.com/coreos/coreos-vagrant

* docker Debian image
https://index.docker.io/_/debian/

* docker-brew
docker-brew is a command-line tool used to build the docker standard library. 
https://github.com/dotcloud/stackbrew/
https://github.com/dotcloud/stackbrew/blob/master/library/debian

https://github.com/blog/530-how-we-made-github-fast

http://queues.io/
http://jasonwilder.com/blog/2012/01/03/centralized-logging/
http://jasonwilder.com/blog/2013/07/16/centralized-logging-architecture/

http://kitchen.ci/
http://www.howtoforge.com/setting-up-a-high-availability-load-balancer-with-haproxy-keepalived-on-debian-lenny
