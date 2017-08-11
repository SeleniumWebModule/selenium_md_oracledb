class selenium_md_oracledb::oracle::exec::initializationdata::constantes::init {
	file {'initializationdata': 
		ensure  => 'directory',
		path    => "${selenium_md_oracledb::oracleHome}/scripts/initializationdata",
		owner   => 'oracle',
		group   => 'dba',
	} ->

	file {'constantes': 
		ensure  => 'directory',
		path    => "${selenium_md_oracledb::oracleHome}/scripts/initializationdata/constantes/",
		owner   => 'oracle',
		group   => 'dba',
	} ->	

	file {'brasil': 
		ensure  => 'directory',
		path    => "${selenium_md_oracledb::oracleHome}/scripts/initializationdata/constantes/brasil",
		owner   => 'oracle',
		group   => 'dba',
	} 

	include selenium_md_oracledb::oracle::exec::initializationdata::constantes::nodo
	include selenium_md_oracledb::oracle::exec::initializationdata::constantes::brasil::tipoparada
	include selenium_md_oracledb::oracle::exec::initializationdata::constantes::brasil::pais
	include selenium_md_oracledb::oracle::exec::initializationdata::constantes::brasil::estado
	include selenium_md_oracledb::oracle::exec::initializationdata::constantes::brasil::plaza
	include selenium_md_oracledb::oracle::exec::initializationdata::constantes::brasil::ciudad
	include selenium_md_oracledb::oracle::exec::initializationdata::constantes::brasil::colonia
	include selenium_md_oracledb::oracle::exec::initializationdata::constantes::brasil::parada
	include selenium_md_oracledb::oracle::exec::initializationdata::constantes::brasil::moneda
	include selenium_md_oracledb::oracle::exec::initializationdata::constantes::brasil::orgaoconcedente
}