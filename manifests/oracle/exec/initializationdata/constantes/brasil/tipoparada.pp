class selenium_md_oracledb::oracle::exec::initializationdata::constantes::brasil::tipoparada {
	require selenium_md_oracledb::oracle::exec::initializationdata::constantes::nodo

	$pathFile = "${selenium_md_oracledb::oracleHome}/scripts/initializationdata/constantes/brasil"

	file {'insert_tipo_parada':
		ensure => file,
		path   => "${pathFile}/tipo_parada.sql",
		owner  => 'oracle',
		group  => 'dba',
		mode   => '0770',
		source => 'puppet:///modules/selenium_md_oracledb/initializationdata/constantes/brasil/tipo_parada.sql'
	} ->

	exec {'insert_tipo_parada':
		command     => "sqlplus ${selenium_md_oracledb::userdb}/${selenium_md_oracledb::passdb} as sysdba @tipo_parada.sql",
		path        => "${selenium_md_oracledb::oracleHome}/bin:/usr/bin",
		cwd         => $pathFile,
		user        => 'oracle',
		environment => ["ORACLE_HOME=${selenium_md_oracledb::oracleHome}", "ORACLE_SID=${selenium_md_oracledb::sid}"],
		timeout     => 0
	} 
}