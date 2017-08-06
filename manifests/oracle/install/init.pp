class selenium_md_oracledb::oracle::install::init {
	require selenium_md_oracledb::kernel::init

	include selenium_md_oracledb::oracle::install::dependencies
	include selenium_md_oracledb::oracle::install::prepare	
	include selenium_md_oracledb::oracle::install::doinstall
}