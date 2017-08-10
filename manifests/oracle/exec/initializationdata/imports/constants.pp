class selenium_md_oracledb::oracle::exec::initializationdata::imports::constants
	require selenium_md_oracledb::oracle::exec::initializationdata::constantes::orgaoconcedente

	$pathFile = "${selenium_md_oracledb::oracleHome}/scripts/initializationdata/imports"

	file {'insert_constants':
		ensure => file,
		path   => "${pathFile}/constants.sql",
		owner  => 'oracle',
		group  => 'dba',
		mode   => '0770',
		source => 'puppet:///modules/selenium_md_oracledb/initializationdata/imports/constants.sql'
	} ->

	exec {'insert_constants':
		command     => "sqlplus ${selenium_md_oracledb::userdb}/${selenium_md_oracledb::passdb} as sysdba @constants.sql",
		path        => "${selenium_md_oracledb::oracleHome}/bin:/usr/bin",
		cwd         => $pathFile,
		user        => 'oracle',
		environment => ["ORACLE_HOME=${selenium_md_oracledb::oracleHome}", "ORACLE_SID=${selenium_md_oracledb::sid}"],
		timeout     => 0
	}  
}