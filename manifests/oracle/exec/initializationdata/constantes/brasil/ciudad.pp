class selenium_md_oracledb::oracle::exec::initializationdata::constantes::brasil::ciudad {
	require selenium_md_oracledb::oracle::exec::initializationdata::constantes::brasil::plaza

	$pathFile = "${selenium_md_oracledb::oracleHome}/scripts/initializationdata/constantes/brasil"

	file {'insert_ciudad':
		ensure => file,
		path   => "${pathFile}/ciudad.sql",
		owner  => 'oracle',
		group  => 'dba',
		mode   => '0770',
		content => template("selenium_md_oracledb/initializationdata/constantes/brasil/ciudad.sql.erb")
	} ->

	exec {'insert_ciudad':
		command     => "sqlplus ${selenium_md_oracledb::systemusr}/${selenium_md_oracledb::systempass} as sysdba @ciudad.sql > insert_ciudad.log",
		path        => "${selenium_md_oracledb::oracleHome}/bin:/usr/bin",
		cwd         => $pathFile,
		user        => 'oracle',
		environment => ["ORACLE_HOME=${selenium_md_oracledb::oracleHome}", "ORACLE_SID=${selenium_md_oracledb::sid}"],
		unless      => "test -f insert_ciudad.log",
		timeout     => 0
	} 
}