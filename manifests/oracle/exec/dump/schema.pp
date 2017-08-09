class selenium_md_oracledb::oracle::exec::dump::schema {

	require selenium_md_oracledb::oracle::exec::dump::tablespace

	$userdb = $selenium_md_oracledb::userdb
	$passdb = $selenium_md_oracledb::passdb

	file {'schema':
		ensure => file,
		path   => "${selenium_md_oracledb::oracleHome}/scripts/schema.sql",
		owner  => 'oracle',
		group  => 'dba',
		mode   => '0770',
		content => template("selenium_md_oracledb/dump/sql/schema.sql.erb"),
	} ->

	exec {'create_schema':
		command     => "sqlplus ${selenium_md_oracledb::systemusr}/${selenium_md_oracledb::systempass} as sysdba @schema.sql",
		path        => "${selenium_md_oracledb::oracleHome}/bin:/usr/bin",
		cwd         => "${selenium_md_oracledb::oracleHome}/scripts",
		user        => 'oracle',
		environment => ["ORACLE_HOME=${selenium_md_oracledb::oracleHome}", "ORACLE_SID=${selenium_md_oracledb::sid}"]
	} 
}