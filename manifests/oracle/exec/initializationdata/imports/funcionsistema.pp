class selenium_md_oracledb::oracle::exec::initializationdata::imports::funcionsistema {
	require selenium_md_oracledb::oracle::exec::initializationdata::imports::constantes

	$pathFile = "${selenium_md_oracledb::oracleHome}/scripts/initializationdata/imports"

	file {'insert_funcion_sistema':
		ensure => file,
		path   => "${pathFile}/funcion_sistema.sql",
		owner  => 'oracle',
		group  => 'dba',
		mode   => '0770',
		content => template("selenium_md_oracledb/initializationdata/imports/funcion_sistema.sql.erb")
	} ->

	exec {'insert_funcion_sistema':
		command     => "sqlplus ${selenium_md_oracledb::systemusr}/${selenium_md_oracledb::systempass} as sysdba @funcion_sistema.sql > insert_funcion_sistema.log",
		path        => "${selenium_md_oracledb::oracleHome}/bin:/usr/bin",
		cwd         => $pathFile,
		user        => 'oracle',
		environment => ["ORACLE_HOME=${selenium_md_oracledb::oracleHome}", "ORACLE_SID=${selenium_md_oracledb::sid}"],
		unless      => "test -f insert_funcion_sistema.log",
		timeout     => 0
	}  
}