class selenium_md_oracledb::oracle::exec::dump::init {
	require selenium_md_oracledb::oracle::configure::service

	include selenium_md_oracledb::oracle::exec::dump::tablespace
	include selenium_md_oracledb::oracle::exec::dump::schema
	include selenium_md_oracledb::oracle::exec::dump::types
	include selenium_md_oracledb::oracle::exec::dump::sequences
	include selenium_md_oracledb::oracle::exec::dump::tables
	include selenium_md_oracledb::oracle::exec::dump::views
	include selenium_md_oracledb::oracle::exec::dump::indexes
	include selenium_md_oracledb::oracle::exec::dump::constraints
	include selenium_md_oracledb::oracle::exec::dump::triggers
	include selenium_md_oracledb::oracle::exec::dump::functions
	include selenium_md_oracledb::oracle::exec::dump::packages
	include selenium_md_oracledb::oracle::exec::dump::procedures
}