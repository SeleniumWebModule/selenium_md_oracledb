class selenium_md_oracledb::oracle::exec::initializationdata::imports::init {
	require selenium_md_oracledb::oracle::exec::initializationdata::constantes::init

	file {'imports': 
		ensure  => 'directory',
		path    => "${selenium_md_oracledb::oracleHome}/scripts/initializationdata/imports",
		owner   => 'oracle',
		group   => 'dba',
	} 

	include selenium_md_oracledb::oracle::exec::initializationdata::imports::sistema
	include selenium_md_oracledb::oracle::exec::initializationdata::imports::constantes
	include selenium_md_oracledb::oracle::exec::initializationdata::imports::funcionsistema
	include selenium_md_oracledb::oracle::exec::initializationdata::imports::motivocancelacion
	include selenium_md_oracledb::oracle::exec::initializationdata::imports::tipovenda
}