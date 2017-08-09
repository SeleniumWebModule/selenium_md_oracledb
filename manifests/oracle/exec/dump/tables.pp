class selenium_md_oracledb::oracle::exec::dump::tables {
	require selenium_md_oracledb::oracle::exec::dump::sequences

	$userdb = $selenium_md_oracledb::userdb

	file {'create_tables':
		ensure => file,
		path   => "${selenium_md_oracledb::oracleHome}/scripts/tables.sql",
		owner  => 'oracle',
		group  => 'dba',
		mode   => '0770',
		content => template("selenium_md_oracledb/tables.sql.erb"),
	} ->

	exec {'create_tables':
		command     => "sqlplus ${selenium_md_oracledb::systemusr}/${selenium_md_oracledb::systempass} as sysdba @tables.sql",
		path        => "${selenium_md_oracledb::oracleHome}/bin:/usr/bin",
		cwd         => "${selenium_md_oracledb::oracleHome}/scripts",
		user        => 'oracle',
		environment => ["ORACLE_HOME=${selenium_md_oracledb::oracleHome}", "ORACLE_SID=${selenium_md_oracledb::sid}"],
		timeout     => 0
	} 
}