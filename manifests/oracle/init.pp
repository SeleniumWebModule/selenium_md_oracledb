class selenium_md_oracledb::oracle::init {
	require selenium_md_oracledb::kernel::init

	include selenium_md_oracledb::oracle::install::init
	include selenium_md_oracledb::oracle::configure::init
}