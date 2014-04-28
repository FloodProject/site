Pre-requisites
---------------

* VirtualBox (https://www.virtualbox.org)
* Vagrant (http://www.vagrantup.com)
* Cygwin SSH tools (http://www.cygwin.com)

Bootstrapping
-------------

Vagrant provides easy to configure, reproducible, and portable work environments
built on top of industry-standard technology and controlled by a single consistent
workflow to help maximize the productivity and flexibility of you and your team.

We use Vagrant to setup a base Debian development machine that we use to bootstrap
the rest of the project.

To launch a new development VM, just invoke `vagrant` from the `debian` folder.

```shell
vagrant init ffuenf/debian-7.4.0-amd64
vagrant plugin install vagrant-vbguest
vagrant up
```

SSH access
-----------

You can connect to the machine via SSH with `vagrant ssh`.

If you are running on Windows, then you'll need to install some SSH tools since the 
OS does not provide it out-of-the-box. Run the Cygwin setup and install the `openssh`
package.

Provisioning
------------

Docker needs a more recent kernel than Debian Wheezy provides, let's install a more recent one:

```shell
sudo sh -c "echo deb http://ftp.us.debian.org/debian wheezy-backports main > /etc/apt/sources.list.d/wheezy-backports.list"
sudo apt-get update -y
sudo apt-get -t wheezy-backports install -y linux-image-amd64 linux-headers-amd64
```

We also need to install some native build tools to be able to re-build the VirtualBox guest
additions the next time we launch the machine (thanks to the `vagrant-vbguest` Vagrant plugin
we installed before).

```shell
sudo apt-get install -y build-essential
```

After that's installed, simply `vagrant reload` your machine and the VirtualBox extras should
automatically work.

Now we can install Docker from the official repo:

```
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
sudo sh -c "echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"
sudo apt-get update -y
sudo apt-get install -y lxc-docker 
```

After the shell is up, we can finally provision it with some Lua dev tools.

```shell
sudo apt-get install -y lua5.1 lua-filesystem
```