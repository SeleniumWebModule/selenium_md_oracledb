class selenium_md_oracledb::oracle::exec::dump::init {
	require selenium_md_oracledb::oracle::configure::service

	include selenium_md_oracledb::oracle::exec::dump::tablespace
}