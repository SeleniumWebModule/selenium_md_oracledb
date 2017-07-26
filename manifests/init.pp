# Class: selenium_md_oracledb
# ===========================
#
# Classe que contém o módulo para provisionamento do banco de dados oracle, versão express.
# O Objetivo do módulo é ser gerenciado pelo Selenium Web App e nunca diretamente.
# Para instalar o módulo no servidor do Selenium, fornecer os fontes da instalação 
# do oracle (oracle-xe-11.2.0-1.0.x86_64.rpm.zip)
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'seleniummdoracledb':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name eduardo@rjconsultores.com.br
#
# Copyright
# ---------
#
# Copyright 2017 Eduardo Dicarte.
#
class selenium_md_oracledb {
	# disable the firewall
	service { iptables:
	  enable    => false,
	  ensure    => false,
	  hasstatus => true,
	}

	# set the tmpfs
	mount { '/dev/shm':
	  ensure      => present,
	  atboot      => true,
	  device      => 'tmpfs',
	  fstype      => 'tmpfs',
	  options     => 'size=13500m',
	}

	$all_groups = ['oinstall','dba', 'oracle','oper']
 	group { $all_groups :
  		ensure      => present,
	}

	swap_file::files { 'default':
  		ensure   => present,
	}->

	user { 'oracle' :
	  ensure      => present,
	  uid         => 500,
	  gid         => 'oinstall',
	  groups      => ['oinstall','dba','oper', 'root'],
	  shell       => '/bin/bash',
	  password    => '$1$DSJ51vh6$4XzzwyIOk6Bi/54kglGk3.',
	  home        => "/home/oracle",
	  comment     => "This user oracle was created by Puppet",
	  require     => Group[$all_groups],
	  managehome  => true,
	} ->

	 sysctl { 'kernel.msgmnb':                 ensure => 'present', permanent => 'yes', value => '65536',}
	sysctl { 'kernel.msgmax':                 ensure => 'present', permanent => 'yes', value => '65536',}
	sysctl { 'kernel.shmmax':                 ensure => 'present', permanent => 'yes', value => '2588483584',}
	sysctl { 'kernel.shmall':                 ensure => 'present', permanent => 'yes', value => '2097152',}
	sysctl { 'fs.file-max':                   ensure => 'present', permanent => 'yes', value => '6815744',}
	sysctl { 'net.ipv4.tcp_keepalive_time':   ensure => 'present', permanent => 'yes', value => '1800',}
	sysctl { 'net.ipv4.tcp_keepalive_intvl':  ensure => 'present', permanent => 'yes', value => '30',}
	sysctl { 'net.ipv4.tcp_keepalive_probes': ensure => 'present', permanent => 'yes', value => '5',}
	sysctl { 'net.ipv4.tcp_fin_timeout':      ensure => 'present', permanent => 'yes', value => '30',}
	sysctl { 'kernel.shmmni':                 ensure => 'present', permanent => 'yes', value => '4096', }
	sysctl { 'fs.aio-max-nr':                 ensure => 'present', permanent => 'yes', value => '1048576',}
	sysctl { 'kernel.sem':                    ensure => 'present', permanent => 'yes', value => '250 32000 100 128',}
	sysctl { 'net.ipv4.ip_local_port_range':  ensure => 'present', permanent => 'yes', value => '9000 65500',}
	sysctl { 'net.core.rmem_default':         ensure => 'present', permanent => 'yes', value => '262144',}
	sysctl { 'net.core.rmem_max':             ensure => 'present', permanent => 'yes', value => '4194304', }
	sysctl { 'net.core.wmem_default':         ensure => 'present', permanent => 'yes', value => '262144',}
	sysctl { 'net.core.wmem_max':             ensure => 'present', permanent => 'yes', value => '1048576',}
 	class { 'limits':
  		config => {
             '*'       => { 'nofile'  => { soft => '2048'   , hard => '8192',   },},
             'oracle'  => { 'nofile'  => { soft => '65536'  , hard => '65536',  },
                             'nproc'  => { soft => '2048'   , hard => '16384',  },
                             'stack'  => { soft => '10240'  ,},},
             },
  		use_hiera => false,
	} 

 	$install = [ 'binutils.x86_64', 'compat-libstdc++-33.x86_64', 'glibc.x86_64','ksh.x86_64','libaio.x86_64',
             'libgcc.x86_64', 'libstdc++.x86_64', 'make.x86_64','compat-libcap1.x86_64', 'gcc.x86_64',
             'gcc-c++.x86_64','glibc-devel.x86_64','libaio-devel.x86_64','libstdc++-devel.x86_64',
             'sysstat.x86_64','unixODBC-devel','glibc.i686','libXext.x86_64','libXtst.x86_64']
	 
	package { $install:
	  ensure  => present,
	} ->

	exec {'copy_arquive_to_install':
		command => 'cp *.zip /tmp/',
		user => 'oracle',
		group => 'dba',
		path => '/usr/bin',
		cwd => '/vagrant/pkg'
	} ->

	oradb::installdb { '112010_Linux-x86-64':
  		version       => '11.2.0.1',
  		file          => 'linux.x64_11gR2_database',
  		database_type => 'SE',
  		oracle_base   => '/oracle',
  		oracle_home   => '/oracle/product/11.2/db',
  		user          => 'oracle',
  		group         => 'dba',
  		group_install => 'oinstall',
  		group_oper    => 'oper',
  		download_dir  => '/tmp/',
  		zip_extract   => true,
  	}
}