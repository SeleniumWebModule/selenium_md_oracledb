class selenium_md_oracledb::oracle::exec::initializationdata::imports::tipovenda {
	require selenium_md_oracledb::oracle::exec::initializationdata::imports::motivocancelacion

	$pathFile = "${selenium_md_oracledb::oracleHome}/scripts/initializationdata/imports"

	file {'insert_tipo_venda':
		ensure => file,
		path   => "${pathFile}/tipo_venda.sql",
		owner  => 'oracle',
		group  => 'dba',
		mode   => '0770',
		content => template("selenium_md_oracledb/initializationdata/imports/tipo_venda.sql.erb")
	} ->

	exec {'insert_tipo_venda':
		command     => "sqlplus ${selenium_md_oracledb::systemusr}/${selenium_md_oracledb::systempass} as sysdba @insert_tipo_venda.sql > tipo_venda.log",
		path        => "${selenium_md_oracledb::oracleHome}/bin:/usr/bin",
		cwd         => $pathFile,
		user        => 'oracle',
		environment => ["ORACLE_HOME=${selenium_md_oracledb::oracleHome}", "ORACLE_SID=${selenium_md_oracledb::sid}"],
		unless      => "test -f insert_tipo_venda.log",
		timeout     => 0
	}  
}