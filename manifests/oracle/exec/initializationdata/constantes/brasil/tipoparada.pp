class selenium_md_oracledb::oracle::exec::initializationdata::constantes::brasil::tipoparada {
	require selenium_md_oracledb::oracle::exec::initializationdata::constantes::nodo

	$pathFile = "${selenium_md_oracledb::oracleHome}/scripts/initializationdata/constantes/brasil"

	file {'insert_tipo_parada':
		ensure => file,
		path   => "${pathFile}/tipo_parada.sql",
		owner  => 'oracle',
		group  => 'dba',
		mode   => '0770',
		content => template("selenium_md_oracledb/initializationdata/constantes/brasil/tipo_parada.sql.erb")
	} ->

	exec {'insert_tipo_parada':
		command     => "sqlplus ${selenium_md_oracledb::systemusr}/${selenium_md_oracledb::systempass} as sysdba @tipo_parada.sql > insert_tipo_parada.log",
		path        => "${selenium_md_oracledb::oracleHome}/bin:/usr/bin",
		cwd         => $pathFile,
		user        => 'oracle',
		environment => ["ORACLE_HOME=${selenium_md_oracledb::oracleHome}", "ORACLE_SID=${selenium_md_oracledb::sid}"],
		unless      => "test -f insert_tipo_parada.log",
		timeout     => 0
	} 
}