class selenium_md_oracledb::oracle::install::prepare {
	require selenium_md_oracledb::oracle::install::dependencies 

	$all_groups = ['oinstall','dba', 'oracle','oper']

	# disable the firewall
	service { iptables:
	  enable    => false,
	  ensure    => false,
	  hasstatus => true,
	} 

 	group { $all_groups :
  		ensure      => present,
	} ->

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

	file {'/opt/oradb/':		
		ensure => 'directory',
		owner  => 'oracle',
		group  => 'dba',
		mode   => '0750',
		ignore => 'ls /opt/oradb/u01/'
	} ->

	exec {'copy_arquive_to_install':
		command => 'cp *.zip /opt/oradb',
		user => 'oracle',
		group => 'dba',
		path => '/usr/bin',
		cwd => '/vagrant/pkg',
		unless      => 'ls /opt/oradb/u01/',
	} ->  
	
	exec {'extract_part1':
		command => 'unzip linux.x64_11gR2_database_1of2.zip',
		user => 'oracle',
		group => 'dba',
		path => '/usr/bin',
		cwd => '/opt/oradb',
		timeout => 0,
		unless      => 'ls /opt/oradb/u01/',
	}  ->

	exec {'extract_part2':
		command => 'unzip linux.x64_11gR2_database_2of2.zip',
		user => 'oracle',
		group => 'dba',
		path => '/usr/bin',
		cwd => '/opt/oradb',
		timeout => 0,
		unless      => 'ls /opt/oradb/u01/',
	} 
}