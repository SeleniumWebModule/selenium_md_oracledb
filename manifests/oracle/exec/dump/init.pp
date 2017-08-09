class selenium_md_oracledb::oracle::exec::dump::init {
	require selenium_md_oracledb::oracle::configure::service

	include selenium_md_oracledb::oracle::exec::dump::tablespace
	include selenium_md_oracledb::oracle::exec::dump::schema
	include selenium_md_oracledb::oracle::exec::dump::types
	include selenium_md_oracledb::oracle::exec::dump::sequences
	include selenium_md_oracledb::oracle::exec::dump::createtables
	include selenium_md_oracledb::oracle::exec::dump::views
	include selenium_md_oracledb::oracle::exec::dump::indexes
}