class selenium_md_oracledb::oracle::exec::initializationdata::constantes::brasil::moneda {
	require selenium_md_oracledb::oracle::exec::initializationdata::constantes::brasil::parada

	$pathFile = "${selenium_md_oracledb::oracleHome}/scripts/initializationdata/constantes/brasil"

	file {'insert_moneda':
		ensure => file,
		path   => "${pathFile}/moneda.sql",
		owner  => 'oracle',
		group  => 'dba',
		mode   => '0770',
		content => template("selenium_md_oracledb/initializationdata/constantes/brasil/moneda.sql.erb")
	} ->

	exec {'insert_moneda':
		command     => "sqlplus ${selenium_md_oracledb::systemusr}/${selenium_md_oracledb::systempass} as sysdba @moneda.sql > insert_moneda.log",
		path        => "${selenium_md_oracledb::oracleHome}/bin:/usr/bin",
		cwd         => $pathFile,
		user        => 'oracle',
		environment => ["ORACLE_HOME=${selenium_md_oracledb::oracleHome}", "ORACLE_SID=${selenium_md_oracledb::sid}"],
		unless      => "test -f insert_moneda.log",
		timeout     => 0
	} 
}