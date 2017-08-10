class selenium_md_oracledb::oracle::exec::initializationdata::imports::funcionsistema
	require selenium_md_oracledb::oracle::exec::initializationdata::imports::constants

	$pathFile = "${selenium_md_oracledb::oracleHome}/scripts/initializationdata/imports"

	file {'insert_funcion_sistema':
		ensure => file,
		path   => "${pathFile}/funcion_sistema.sql",
		owner  => 'oracle',
		group  => 'dba',
		mode   => '0770',
		source => 'puppet:///modules/selenium_md_oracledb/initializationdata/imports/funcion_sistema.sql'
	} ->

	exec {'insert_funcion_sistema':
		command     => "sqlplus ${selenium_md_oracledb::userdb}/${selenium_md_oracledb::passdb} as sysdba @funcion_sistema.sql",
		path        => "${selenium_md_oracledb::oracleHome}/bin:/usr/bin",
		cwd         => $pathFile,
		user        => 'oracle',
		environment => ["ORACLE_HOME=${selenium_md_oracledb::oracleHome}", "ORACLE_SID=${selenium_md_oracledb::sid}"],
		timeout     => 0
	}  
}