class selenium_md_oracledb::oracle::exec::dump::tablespace {
	require selenium_md_oracledb::oracle::configure::service

	$dbname = $selenium_md_oracledb::dbname

	file {'tablespace':
		ensure => file,
		path   => "${selenium_md_oracledb::oracleHome}/scripts/tablespace.sql",
		owner  => 'oracle',
		group  => 'dba',
		mode   => '0770',
		content => template("selenium_md_oracledb/tablespace.sql.erb"),
	} ->

	exec {'create_tablespace':
		command     => "sqlplus ${selenium_md_oracledb::systemusr}/${selenium_md_oracledb::systempass} as sysdba @tablespace.sql",
		path        => "${selenium_md_oracledb::oracleHome}/bin:/usr/bin",
		cwd         => "${selenium_md_oracledb::oracleHome}/scripts",
		user        => 'oracle',
		environment => ["ORACLE_HOME=${selenium_md_oracledb::oracleHome}", "ORACLE_SID=${selenium_md_oracledb::sid}"]
	} 
}