# Class: selenium_md_oracledb
# ===========================
#
# Classe que contém o módulo para provisionamento do banco de dados oracle, versão express.
# O Objetivo do módulo é ser gerenciado pelo Selenium Web App e nunca diretamente.
# Para instalar o módulo no servidor do Selenium, fornecer também os fontes da instalação 
# do oracle
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
	}

	package {'unzip':
		ensure => present
	} ->

	exec {'copy_arquive_to_install':
		command => 'cp -R /vagrant/pkg/*.zip /opt',
		user => 'root',
		group => 'root',
		path => '/usr/bin'
	} ->

	exec {'extract_files_to_install':
		command => 'unzip linux.x64_11gR2_database_1of2.zip',
		user => 'root',
		group => 'root',
		path => '/usr/bin',
		cwd  => '/opt',
		timeout => 0
	} ->

	class{'selenium_md_oracledb::docker::init':}
}