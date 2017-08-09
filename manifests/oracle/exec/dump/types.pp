class selenium_md_oracledb::oracle::exec::dump::types {
	require selenium_md_oracledb::oracle::exec::dump::schema

	$userdb = $selenium_md_oracledb::userdb

	file {'types':
		ensure => file,
		path   => "${selenium_md_oracledb::oracleHome}/scripts/types.sql",
		owner  => 'oracle',
		group  => 'dba',
		mode   => '0770',
		content => template("selenium_md_oracledb/dump/sql/types.sql.erb"),
	} ->

	exec {'create_types':
		command     => "sqlplus ${selenium_md_oracledb::systemusr}/${selenium_md_oracledb::systempass} as sysdba @types.sql",
		path        => "${selenium_md_oracledb::oracleHome}/bin:/usr/bin",
		cwd         => "${selenium_md_oracledb::oracleHome}/scripts",
		user        => 'oracle',
		environment => ["ORACLE_HOME=${selenium_md_oracledb::oracleHome}", "ORACLE_SID=${selenium_md_oracledb::sid}"]
	} 
}