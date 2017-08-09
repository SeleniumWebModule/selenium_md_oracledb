class selenium_md_oracledb::oracle::exec::dump::triggers {
	require selenium_md_oracledb::oracle::exec::dump::constraints

	$userdb = $selenium_md_oracledb::userdb

	file {'create_triggers':
		ensure => file,
		path   => "${selenium_md_oracledb::oracleHome}/scripts/triggers.sql",
		owner  => 'oracle',
		group  => 'dba',
		mode   => '0770',
		content => template("selenium_md_oracledb/dump/sql/triggers.sql.erb"),
	} ->

	exec {'create_triggers':
		command     => "sqlplus ${selenium_md_oracledb::systemusr}/${selenium_md_oracledb::systempass} as sysdba @triggers.sql",
		path        => "${selenium_md_oracledb::oracleHome}/bin:/usr/bin",
		cwd         => "${selenium_md_oracledb::oracleHome}/scripts",
		user        => 'oracle',
		environment => ["ORACLE_HOME=${selenium_md_oracledb::oracleHome}", "ORACLE_SID=${selenium_md_oracledb::sid}"],
		timeout     => 0
	} 
}