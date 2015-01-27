

node /storage/ {

  notify {'Hello, I\'m a storage box!':}

  include common

}

node /client/ {

  notify {'Hello, I\'m a client box!':}

  include common

}

node default {

  notify {'I\'m different!':}

}


## Common resources
class common {

  include repos
  include glusterfs::client

  Package {
    allow_virtual => true,
  }

}

## Repos
class repos {

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
