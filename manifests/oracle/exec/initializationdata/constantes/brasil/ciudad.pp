class selenium_md_oracledb::oracle::exec::initializationdata::constantes::brasil::ciudad {
	require selenium_md_oracledb::oracle::exec::initializationdata::constantes::plaza

	$pathFile = "${selenium_md_oracledb::oracleHome}/scripts/initializationdata/constantes/brasil"

	file {'insert_ciudad':
		ensure => file,
		path   => "${pathFile}/ciudad.sql",
		owner  => 'oracle',
		group  => 'dba',
		mode   => '0770',
		source => 'puppet:///modules/selenium_md_oracledb/initializationdata/constantes/brasil/ciudad.sql'
	} ->

	exec {'insert_ciudad':
		command     => "sqlplus ${selenium_md_oracledb::userdb}/${selenium_md_oracledb::passdb} as sysdba @ciudad.sql",
		path        => "${selenium_md_oracledb::oracleHome}/bin:/usr/bin",
		cwd         => $pathFile,
		user        => 'oracle',
		environment => ["ORACLE_HOME=${selenium_md_oracledb::oracleHome}", "ORACLE_SID=${selenium_md_oracledb::sid}"],
		timeout     => 0
	} 
}