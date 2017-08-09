class selenium_md_oracledb::oracle::exec::dump::constraints {
	require selenium_md_oracledb::oracle::exec::dump::indexes

	$userdb = $selenium_md_oracledb::userdb

	file {'create_constraints':
		ensure => file,
		path   => "${selenium_md_oracledb::oracleHome}/scripts/constraints.sql",
		owner  => 'oracle',
		group  => 'dba',
		mode   => '0770',
		content => template("selenium_md_oracledb/dump/sql/constraints.sql.erb"),
	} ->

	exec {'create_constraints':
		command     => "sqlplus ${selenium_md_oracledb::systemusr}/${selenium_md_oracledb::systempass} as sysdba @constraints.sql",
		path        => "${selenium_md_oracledb::oracleHome}/bin:/usr/bin",
		cwd         => "${selenium_md_oracledb::oracleHome}/scripts",
		user        => 'oracle',
		environment => ["ORACLE_HOME=${selenium_md_oracledb::oracleHome}", "ORACLE_SID=${selenium_md_oracledb::sid}"],
		timeout     => 0
	} 
}