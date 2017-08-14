class selenium_md_oracledb::oracle::exec::initializationdata::constantes::nodo {
	$pathFile = "${selenium_md_oracledb::oracleHome}/scripts/initializationdata/constantes"

	file {'insert_nodo':
		ensure => file,
		path   => "${pathFile}/nodo.sql",
		owner  => 'oracle',
		group  => 'dba',
		mode   => '0770',
		content => template("selenium_md_oracledb/initializationdata/constantes/nodo.sql.erb")
	} ->

	exec {'insert_nodo':
		command     => "sqlplus ${selenium_md_oracledb::systemusr}/${selenium_md_oracledb::systempass} as sysdba @nodo.sql > insert_nodo.log",
		path        => "${selenium_md_oracledb::oracleHome}/bin:/usr/bin",
		cwd         => $pathFile,
		user        => 'oracle',
		environment => ["ORACLE_HOME=${selenium_md_oracledb::oracleHome}", "ORACLE_SID=${selenium_md_oracledb::sid}"],
		unless      => "test -f insert_nodo.log",
		timeout     => 0
	} 
}