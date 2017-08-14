class selenium_md_oracledb::oracle::exec::initializationdata::constantes::brasil::colonia {
	require selenium_md_oracledb::oracle::exec::initializationdata::constantes::brasil::ciudad

	$pathFile = "${selenium_md_oracledb::oracleHome}/scripts/initializationdata/constantes/brasil"

	file {'insert_colonia':
		ensure => file,
		path   => "${pathFile}/colonia.sql",
		owner  => 'oracle',
		group  => 'dba',
		mode   => '0770',
		content => template("selenium_md_oracledb/initializationdata/constantes/brasil/colonia.sql.erb")
	} ->

	exec {'insert_colonia':
		command     => "sqlplus ${selenium_md_oracledb::systemusr}/${selenium_md_oracledb::systempass} as sysdba @colonia.sql > insert_colonia.log",
		path        => "${selenium_md_oracledb::oracleHome}/bin:/usr/bin",
		cwd         => $pathFile,
		user        => 'oracle',
		environment => ["ORACLE_HOME=${selenium_md_oracledb::oracleHome}", "ORACLE_SID=${selenium_md_oracledb::sid}"],
		unless      => "test -f insert_colonia.log",
		timeout     => 0
	} 
}