class selenium_md_oracledb::oracle::exec::dump::sequences {
	require selenium_md_oracledb::oracle::exec::dump::types

	$userdb = $selenium_md_oracledb::userdb

	file {'sequences':
		ensure => file,
		path   => "${selenium_md_oracledb::oracleHome}/scripts/sequences.sql",
		owner  => 'oracle',
		group  => 'dba',
		mode   => '0770',
		content => template("selenium_md_oracledb/sequences.sql.erb"),
	} ->

	exec {'create_sequences':
		command     => "sqlplus ${selenium_md_oracledb::systemusr}/${selenium_md_oracledb::systempass} as sysdba @sequences.sql",
		path        => "${selenium_md_oracledb::oracleHome}/bin:/usr/bin",
		cwd         => "${selenium_md_oracledb::oracleHome}/scripts",
		user        => 'oracle',
		environment => ["ORACLE_HOME=${selenium_md_oracledb::oracleHome}", "ORACLE_SID=${selenium_md_oracledb::sid}"]
	} 
}