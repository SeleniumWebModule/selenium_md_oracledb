class selenium_md_oracledb::oracle::exec::initializationdata::constantes::nodo {
	$pathFile = "${selenium_md_oracledb::oracleHome}/scripts/initializationdata/constantes"

	file {'insert_nodo':
		ensure => file,
		path   => "${pathFile}/nodo.sql",
		owner  => 'oracle',
		group  => 'dba',
		mode   => '0770',
		source => 'puppet:///modules/selenium_md_oracledb/initializationdata/constantes/nodo.sql'
	} ->

	exec {'insert_nodo':
		command     => "sqlplus ${selenium_md_oracledb::userdb}/${selenium_md_oracledb::passdb} as sysdba @nodo.sql",
		path        => "${selenium_md_oracledb::oracleHome}/bin:/usr/bin",
		cwd         => $pathFile,
		user        => 'oracle',
		environment => ["ORACLE_HOME=${selenium_md_oracledb::oracleHome}", "ORACLE_SID=${selenium_md_oracledb::sid}"],
		timeout     => 0
	} 
}