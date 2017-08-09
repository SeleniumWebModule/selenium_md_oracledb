class selenium_md_oracledb::oracle::exec::dump::indexes {
	require selenium_md_oracledb::oracle::exec::dump::views

	$userdb = $selenium_md_oracledb::userdb

	file {'create_indexes':
		ensure => file,
		path   => "${selenium_md_oracledb::oracleHome}/scripts/indexes.sql",
		owner  => 'oracle',
		group  => 'dba',
		mode   => '0770',
		content => template("selenium_md_oracledb/sql/indexes.sql.erb"),
	} ->

	exec {'create_indexes':
		command     => "sqlplus ${selenium_md_oracledb::systemusr}/${selenium_md_oracledb::systempass} as sysdba @indexes.sql",
		path        => "${selenium_md_oracledb::oracleHome}/bin:/usr/bin",
		cwd         => "${selenium_md_oracledb::oracleHome}/scripts",
		user        => 'oracle',
		environment => ["ORACLE_HOME=${selenium_md_oracledb::oracleHome}", "ORACLE_SID=${selenium_md_oracledb::sid}"]
	} 
}