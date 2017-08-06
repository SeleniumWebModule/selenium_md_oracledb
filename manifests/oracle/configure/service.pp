class selenium_md_oracledb::oracle::configure::service {
	file {'listener':
		ensure  => file,
		path    => "${selenium_md_oracledb::oracleHome}/network/admin/listener.ora",
		owner   => 'oracle',
		group   => 'oinstall',
		mode    => '0770',
		content => template("selenium_md_oracledb/listener.ora.erb"),
	} ->

	exec {'orcl-oradb':
    	command => 'lsnrctl start',
    	user    => 'oracle',
    	path    => "${selenium_md_oracledb::oracleHome}/bin:/usr/bin",
    	environment => "ORACLE_HOME=${selenium_md_oracledb::oracleHome}",
    	unless      =>"netstat -pultan | grep 1521"
  	} ->

  	file {'scriptsdir': 
		ensure  => 'directory',
		path    => "${selenium_md_oracledb::oracleHome}/scripts",
		owner   => 'oracle',
		group   => 'dba',
	} ->

  	file {'startup':
		ensure => file,
		path   => "${selenium_md_oracledb::oracleHome}/scripts/startup.sql",
		owner  => 'oracle',
		group  => 'dba',
		mode   => '0770',
		source => 'puppet:///modules/selenium_md_oracledb/startup.sql'
	} ->

	exec {'init_database':
		command     => "sqlplus ${selenium_md_oracledb::systemusr}/${selenium_md_oracledb::systempass} as sysdba @startup.sql",
		path        => "${selenium_md_oracledb::oracleHome}/bin:/usr/bin",
		cwd         => "${selenium_md_oracledb::oracleHome}/scripts",
		user        => 'oracle',
		environment => "ORACLE_HOME=${selenium_md_oracledb::oracleHome}"
	} 
}