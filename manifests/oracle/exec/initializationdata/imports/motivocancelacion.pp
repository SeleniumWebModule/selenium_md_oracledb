class selenium_md_oracledb::oracle::exec::initializationdata::imports::motivocancelacion
	require selenium_md_oracledb::oracle::exec::initializationdata::imports::funcionsistema

	$pathFile = "${selenium_md_oracledb::oracleHome}/scripts/initializationdata/imports"

	file {'insert_motivo_cancelacion':
		ensure => file,
		path   => "${pathFile}/motivo_cancelacion.sql",
		owner  => 'oracle',
		group  => 'dba',
		mode   => '0770',
		source => 'puppet:///modules/selenium_md_oracledb/initializationdata/imports/motivo_cancelacion.sql'
	} ->

	exec {'insert_motivo_cancelacion':
		command     => "sqlplus ${selenium_md_oracledb::userdb}/${selenium_md_oracledb::passdb} as sysdba @motivo_cancelacion.sql",
		path        => "${selenium_md_oracledb::oracleHome}/bin:/usr/bin",
		cwd         => $pathFile,
		user        => 'oracle',
		environment => ["ORACLE_HOME=${selenium_md_oracledb::oracleHome}", "ORACLE_SID=${selenium_md_oracledb::sid}"],
		timeout     => 0
	}  
}