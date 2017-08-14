class selenium_md_oracledb::oracle::exec::initializationdata::constantes::brasil::plaza {
	require selenium_md_oracledb::oracle::exec::initializationdata::constantes::brasil::estado

	$pathFile = "${selenium_md_oracledb::oracleHome}/scripts/initializationdata/constantes/brasil"

	file {'insert_plaza':
		ensure => file,
		path   => "${pathFile}/plaza.sql",
		owner  => 'oracle',
		group  => 'dba',
		mode   => '0770',
		content => template("selenium_md_oracledb/initializationdata/constantes/brasil/plaza.sql.erb")
	} ->

	exec {'insert_plaza':
		command     => "sqlplus ${selenium_md_oracledb::systemusr}/${selenium_md_oracledb::systempass} as sysdba @plaza.sql > insert_plaza.log",
		path        => "${selenium_md_oracledb::oracleHome}/bin:/usr/bin",
		cwd         => $pathFile,
		user        => 'oracle',
		environment => ["ORACLE_HOME=${selenium_md_oracledb::oracleHome}", "ORACLE_SID=${selenium_md_oracledb::sid}"],
		unless      => "test -f insert_plaza.log",
		timeout     => 0
	} 
}