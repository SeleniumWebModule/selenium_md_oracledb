class selenium_md_oracledb::oracle::exec::initializationdata::constantes::brasil::moneda {
	require selenium_md_oracledb::oracle::exec::initializationdata::constantes::parada

	$pathFile = "${selenium_md_oracledb::oracleHome}/scripts/initializationdata/constantes/brasil"

	file {'insert_moneda':
		ensure => file,
		path   => "${pathFile}/moneda.sql",
		owner  => 'oracle',
		group  => 'dba',
		mode   => '0770',
		source => 'puppet:///modules/selenium_md_oracledb/initializationdata/constantes/brasil/moneda.sql'
	} ->

	exec {'insert_moneda':
		command     => "sqlplus ${selenium_md_oracledb::userdb}/${selenium_md_oracledb::passdb} as sysdba @moneda.sql",
		path        => "${selenium_md_oracledb::oracleHome}/bin:/usr/bin",
		cwd         => $pathFile,
		user        => 'oracle',
		environment => ["ORACLE_HOME=${selenium_md_oracledb::oracleHome}", "ORACLE_SID=${selenium_md_oracledb::sid}"],
		timeout     => 0
	} 
}