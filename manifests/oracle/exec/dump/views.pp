class selenium_md_oracledb::oracle::exec::dump::views {
	require selenium_md_oracledb::oracle::exec::dump::tables

	$userdb = $selenium_md_oracledb::userdb

	file {'create_views':
		ensure => file,
		path   => "${selenium_md_oracledb::oracleHome}/scripts/views.sql",
		owner  => 'oracle',
		group  => 'dba',
		mode   => '0770',
		content => template("selenium_md_oracledb/views.sql.erb"),
	} ->

	exec {'create_views':
		command     => "sqlplus ${selenium_md_oracledb::systemusr}/${selenium_md_oracledb::systempass} as sysdba @views.sql",
		path        => "${selenium_md_oracledb::oracleHome}/bin:/usr/bin",
		cwd         => "${selenium_md_oracledb::oracleHome}/scripts",
		user        => 'oracle',
		environment => ["ORACLE_HOME=${selenium_md_oracledb::oracleHome}", "ORACLE_SID=${selenium_md_oracledb::sid}"]
	} 
}