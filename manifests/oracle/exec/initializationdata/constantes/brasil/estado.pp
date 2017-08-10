class selenium_md_oracledb::oracle::exec::initializationdata::constantes::brasil::estado {
	require selenium_md_oracledb::oracle::exec::initializationdata::constantes::pais

	$pathFile = "${selenium_md_oracledb::oracleHome}/scripts/initializationdata/constantes/brasil"

	file {'insert_estado':
		ensure => file,
		path   => "${pathFile}/estado.sql",
		owner  => 'oracle',
		group  => 'dba',
		mode   => '0770',
		source => 'puppet:///modules/selenium_md_oracledb/initializationdata/constantes/brasil/estado.sql'
	} ->

	exec {'insert_estado':
		command     => "sqlplus ${selenium_md_oracledb::userdb}/${selenium_md_oracledb::passdb} as sysdba @estado.sql",
		path        => "${selenium_md_oracledb::oracleHome}/bin:/usr/bin",
		cwd         => $pathFile,
		user        => 'oracle',
		environment => ["ORACLE_HOME=${selenium_md_oracledb::oracleHome}", "ORACLE_SID=${selenium_md_oracledb::sid}"],
		timeout     => 0
	} 
}