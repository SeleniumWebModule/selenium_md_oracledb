class selenium_md_oracledb::oracle::exec::initializationdata::constantes::brasil::orgaoconcedente {
	require selenium_md_oracledb::oracle::exec::initializationdata::constantes::moneda

	$pathFile = "${selenium_md_oracledb::oracleHome}/scripts/initializationdata/constantes/brasil"

	file {'insert_orgao_concedente':
		ensure => file,
		path   => "${pathFile}/orgao_concedente.sql",
		owner  => 'oracle',
		group  => 'dba',
		mode   => '0770',
		source => 'puppet:///modules/selenium_md_oracledb/initializationdata/constantes/brasil/orgao_concedente.sql'
	} ->

	exec {'insert_orgao_concedente':
		command     => "sqlplus ${selenium_md_oracledb::userdb}/${selenium_md_oracledb::passdb} as sysdba @orgao_concedente.sql",
		path        => "${selenium_md_oracledb::oracleHome}/bin:/usr/bin",
		cwd         => $pathFile,
		user        => 'oracle',
		environment => ["ORACLE_HOME=${selenium_md_oracledb::oracleHome}", "ORACLE_SID=${selenium_md_oracledb::sid}"],
		timeout     => 0
	} 
}