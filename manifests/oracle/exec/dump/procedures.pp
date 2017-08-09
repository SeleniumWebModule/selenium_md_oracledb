class selenium_md_oracledb::oracle::exec::dump::procedures {
	require selenium_md_oracledb::oracle::exec::dump::packages

	$userdb = $selenium_md_oracledb::userdb

	file {'create_procedures':
		ensure => file,
		path   => "${selenium_md_oracledb::oracleHome}/scripts/procedures.sql",
		owner  => 'oracle',
		group  => 'dba',
		mode   => '0770',
		content => template("selenium_md_oracledb/dump/sql/procedures.sql.erb"),
	} ->

	exec {'create_procedures':
		command     => "sqlplus ${selenium_md_oracledb::systemusr}/${selenium_md_oracledb::systempass} as sysdba @procedures.sql",
		path        => "${selenium_md_oracledb::oracleHome}/bin:/usr/bin",
		cwd         => "${selenium_md_oracledb::oracleHome}/scripts",
		user        => 'oracle',
		environment => ["ORACLE_HOME=${selenium_md_oracledb::oracleHome}", "ORACLE_SID=${selenium_md_oracledb::sid}"],
		timeout     => 0
	} 
}