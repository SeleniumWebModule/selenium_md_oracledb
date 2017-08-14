class selenium_md_oracledb::oracle::exec::initializationdata::imports::constantes {
	require selenium_md_oracledb::oracle::exec::initializationdata::imports::sistema

	$pathFile = "${selenium_md_oracledb::oracleHome}/scripts/initializationdata/imports"

	file {'insert_constantes':
		ensure => file,
		path   => "${pathFile}/constantes.sql",
		owner  => 'oracle',
		group  => 'dba',
		mode   => '0770',
		content => template("selenium_md_oracledb/initializationdata/imports/constantes.sql.erb")
	} ->

	exec {'insert_constantes':
		command     => "sqlplus ${selenium_md_oracledb::systemusr}/${selenium_md_oracledb::systempass} as sysdba @constantes.sql > insert_constantes.log",
		path        => "${selenium_md_oracledb::oracleHome}/bin:/usr/bin",
		cwd         => $pathFile,
		user        => 'oracle',
		environment => ["ORACLE_HOME=${selenium_md_oracledb::oracleHome}", "ORACLE_SID=${selenium_md_oracledb::sid}"],
		unless      => "test -f insert_constantes.log",
		timeout     => 0
	}  
}