class selenium_md_oracledb::oracle::exec::initializationdata::constantes::brasil::pais {
	require selenium_md_oracledb::oracle::exec::initializationdata::constantes::tipoparada

	$pathFile = "${selenium_md_oracledb::oracleHome}/scripts/initializationdata/constantes/brasil"

	file {'insert_pais':
		ensure => file,
		path   => "${pathFile}/pais.sql",
		owner  => 'oracle',
		group  => 'dba',
		mode   => '0770',
		source => 'puppet:///modules/selenium_md_oracledb/initializationdata/constantes/brasil/pais.sql'
	} ->

	exec {'insert_pais':
		command     => "sqlplus ${selenium_md_oracledb::userdb}/${selenium_md_oracledb::passdb} as sysdba @pais.sql",
		path        => "${selenium_md_oracledb::oracleHome}/bin:/usr/bin",
		cwd         => $pathFile,
		user        => 'oracle',
		environment => ["ORACLE_HOME=${selenium_md_oracledb::oracleHome}", "ORACLE_SID=${selenium_md_oracledb::sid}"],
		timeout     => 0
	} 
}