class selenium_md_oracledb::oracle::configure::network {
	$path_respfile = "/opt/oradb/database/response/netca.rsp"
	
	file {'netca.rsp':
    	ensure  => file,
    	path    => '/opt/oradb/database/response/netca.rsp',
    	content => template("selenium_md_oracledb/netca.rsp.erb"),
    	ignore => 'ls /opt/oradb/u01/'
  	} ->

	exec { 'configure_oracle_network':
  		command      => "sh netca /silent /responseFile ${path_respfile}",
  		path         => '/usr/bin',
  		cwd          => '/opt/oradb/u01/app/oracle/product/11.2.0/dbhome_1/bin/',
  		user         => 'oracle',
  		unless       => 'ls /opt/oradb/u01/'
  	}
}