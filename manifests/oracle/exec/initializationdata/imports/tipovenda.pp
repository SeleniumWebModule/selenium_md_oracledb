class selenium_md_oracledb::oracle::exec::initializationdata::imports::tipovenda
	require selenium_md_oracledb::oracle::exec::initializationdata::imports::motivocancelacion

	$pathFile = "${selenium_md_oracledb::oracleHome}/scripts/initializationdata/imports"

	file {'insert_tipo_venda':
		ensure => file,
		path   => "${pathFile}/tipo_venda.sql",
		owner  => 'oracle',
		group  => 'dba',
		mode   => '0770',
		source => 'puppet:///modules/selenium_md_oracledb/initializationdata/imports/tipo_venda.sql'
	} ->

	exec {'insert_tipo_venda':
		command     => "sqlplus ${selenium_md_oracledb::userdb}/${selenium_md_oracledb::passdb} as sysdba @tipo_venda.sql",
		path        => "${selenium_md_oracledb::oracleHome}/bin:/usr/bin",
		cwd         => $pathFile,
		user        => 'oracle',
		environment => ["ORACLE_HOME=${selenium_md_oracledb::oracleHome}", "ORACLE_SID=${selenium_md_oracledb::sid}"],
		timeout     => 0
	}  
}