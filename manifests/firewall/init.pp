class selenium_md_oracledb::firewall::init {
	require selenium_md_oracledb::oracle::configure::service

	exec {'disable_firewall':
		command => 'iptables -F',
		user    => 'root',
		path    => '/usr/sbin'
	}
}