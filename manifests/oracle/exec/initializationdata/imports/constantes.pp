class selenium_md_oracledb::oracle::exec::initializationdata::imports::constantes {
	require selenium_md_oracledb::oracle::exec::initializationdata::constantes::brasil::orgaoconcedente

	$pathFile = "${selenium_md_oracledb::oracleHome}/scripts/initializationdata/imports"

	file {'insert_constants':
		ensure => file,
		path   => "${pathFile}/constantes.sql",
		owner  => 'oracle',
		group  => 'dba',
		mode   => '0770',
		content => template("selenium_md_oracledb/initializationdata/imports/constantes.sql.erb"),
		require => File['imports']

	} ->

	exec {'insert_constants':
		command     => "sqlplus ${selenium_md_oracledb::systemusr}/${selenium_md_oracledb::systempass} as sysdba @constantes.sql",
		path        => "${selenium_md_oracledb::oracleHome}/bin:/usr/bin",
		cwd         => $pathFile,
		user        => 'oracle',
		environment => ["ORACLE_HOME=${selenium_md_oracledb::oracleHome}", "ORACLE_SID=${selenium_md_oracledb::sid}"],
		timeout     => 0
	}  
}