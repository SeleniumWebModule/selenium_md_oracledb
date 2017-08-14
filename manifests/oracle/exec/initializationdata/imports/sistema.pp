class selenium_md_oracledb::oracle::exec::initializationdata::imports::sistema {
	require selenium_md_oracledb::oracle::exec::initializationdata::constantes::brasil::orgaoconcedente

	$pathFile = "${selenium_md_oracledb::oracleHome}/scripts/initializationdata/imports"

	file {'insert_sistema':
		ensure => file,
		path   => "${pathFile}/sistema.sql",
		owner  => 'oracle',
		group  => 'dba',
		mode   => '0770',
		content => template("selenium_md_oracledb/initializationdata/imports/sistema.sql.erb"),
		require => File['imports']

	} ->

	exec {'insert_sistema':
		command     => "sqlplus ${selenium_md_oracledb::systemusr}/${selenium_md_oracledb::systempass} as sysdba @sistema.sql > insert_sistemas.log",
		path        => "${selenium_md_oracledb::oracleHome}/bin:/usr/bin",
		cwd         => $pathFile,
		user        => 'oracle',
		environment => ["ORACLE_HOME=${selenium_md_oracledb::oracleHome}", "ORACLE_SID=${selenium_md_oracledb::sid}"],
		unless      => "test -f insert_sistema.log",
		timeout     => 0
	}  
}