

node /storage/ {

  #notify {'Hello, I\'m a storage box!':}

  include common
  contain lvm
  contain glusterfs::server

  Class['lvm']->Class['glusterfs::server']

  create_resources('glusterfs::volume', hiera('glusterfs::volume', {}))

}

node /client/ {

  #notify {'Hello, I\'m a client box!':}

  include common

}

node default {

  notify {'I\'m different!':}

}


## Common resources
class common {

  include repos
  include glusterfs::client

  # FU DNS!
  package { 'avahi':}
  package { 'nss-mdns':}
  service { 'avahi-daemon':
    enable  => true,
    ensure  => running,
    require => Package['avahi'],
  }

}

## Repos
class repos {

  # Process Repositories before anything else
  stage { 'repositories':
    before => Stage['main'],
  }

  exec { 'refresh-yum-cache':
    command     => 'yum makecache',
    path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    refreshonly => true,
  }

  Yumrepo {
    descr      => 'GlusterFS is a clustered file-system capable of scaling to several petabytes.',
    enabled    => '1',
    gpgcheck   => '1',
    gpgkey     => 'http://download.gluster.org/pub/gluster/glusterfs/LATEST/EPEL.repo/pub.key',
    require    => Stage['repositories'],
    notify     => Exec['refresh-yum-cache'],
  }

  yumrepo { 'glusterfs-epel':
    baseurl    => 'http://download.gluster.org/pub/gluster/glusterfs/LATEST/EPEL.repo/epel-$releasever/$basearch/',
  }

  yumrepo { 'glusterfs-noarch-epel':
    baseurl    => 'http://download.gluster.org/pub/gluster/glusterfs/LATEST/EPEL.repo/epel-$releasever/noarch',
  }

}

Package {
  allow_virtual => true,
}