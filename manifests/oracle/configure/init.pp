class selenium_md_oracledb::oracle::configure::init {
	require selenium_md_oracledb::oracle::install::init

	include selenium_md_oracledb::oracle::configure::network
	include selenium_md_oracledb::oracle::configure::database
	include selenium_md_oracledb::oracle::configure::service
	
	include selenium_md_oracledb::firewall::init
}