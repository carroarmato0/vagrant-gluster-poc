# vagrant-gluster-poc

This is a vagrant proof of concept for deploying and running GlusterFS with Puppet.

## Specs

 - Centos 6.6, 1 cpu, 512MB Ram, 19GB /, 477MB /boot
 - Puppet 3.7.3
 - Vbox 4.3.20
 - GlusterFS upstream Repositories


## Setup

The Vagrantfile defines 4 Centos virtual machines.

- 2 Storage VM's running GlusterFS server
- 2 Client VM's using the GlusterFS mount

The 2 Storage VM's will get a second disk /dev/sdb on the fly with 500GB space which will be used as bricks for Gluster.