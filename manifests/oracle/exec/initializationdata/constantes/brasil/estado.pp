class selenium_md_oracledb::oracle::exec::initializationdata::constantes::brasil::estado {
	require selenium_md_oracledb::oracle::exec::initializationdata::constantes::brasil::pais

	$pathFile = "${selenium_md_oracledb::oracleHome}/scripts/initializationdata/constantes/brasil"

	file {'insert_estado':
		ensure => file,
		path   => "${pathFile}/estado.sql",
		owner  => 'oracle',
		group  => 'dba',
		mode   => '0770',
		content => template("selenium_md_oracledb/initializationdata/constantes/brasil/estado.sql.erb")
	} ->

	exec {'insert_estado':
		command     => "sqlplus ${selenium_md_oracledb::systemusr}/${selenium_md_oracledb::systempass} as sysdba @estado.sql > insert_estado.log",
		path        => "${selenium_md_oracledb::oracleHome}/bin:/usr/bin",
		cwd         => $pathFile,
		user        => 'oracle',
		environment => ["ORACLE_HOME=${selenium_md_oracledb::oracleHome}", "ORACLE_SID=${selenium_md_oracledb::sid}"],
		unless      => "test -f insert_estado.log",
		timeout     => 0
	} 
}