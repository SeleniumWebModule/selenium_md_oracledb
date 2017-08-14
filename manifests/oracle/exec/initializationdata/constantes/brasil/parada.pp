class selenium_md_oracledb::oracle::exec::initializationdata::constantes::brasil::parada {
	require selenium_md_oracledb::oracle::exec::initializationdata::constantes::brasil::colonia

	$pathFile = "${selenium_md_oracledb::oracleHome}/scripts/initializationdata/constantes/brasil"

	file {'insert_parada':
		ensure => file,
		path   => "${pathFile}/parada.sql",
		owner  => 'oracle',
		group  => 'dba',
		mode   => '0770',
		content => template("selenium_md_oracledb/initializationdata/constantes/brasil/parada.sql.erb")
	} ->

	exec {'insert_parada':
		command     => "sqlplus ${selenium_md_oracledb::systemusr}/${selenium_md_oracledb::systempass} as sysdba @parada.sql > insert_parada.log",
		path        => "${selenium_md_oracledb::oracleHome}/bin:/usr/bin",
		cwd         => $pathFile,
		user        => 'oracle',
		environment => ["ORACLE_HOME=${selenium_md_oracledb::oracleHome}", "ORACLE_SID=${selenium_md_oracledb::sid}"],
		unless      => "test -f insert_parada.log",
		timeout     => 0
	} 
}