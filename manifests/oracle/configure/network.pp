class selenium_md_oracledb::oracle::configure::network {
  require selenium_md_oracledb::oracle::install::doinstall

  $path_rsp = "/opt/oradb/database/response"
	$path_netca = "${path_rsp}/netca.rsp"
  $oracleHome = "/opt/oradb/u01/app/oracle/product/11.2.0/dbhome_1"
	
	file {'netca.rsp':
    	ensure  => file,
    	path    => $path_netca,
    	content => template("selenium_md_oracledb/netca.rsp.erb"),
    	ignore => "ls ${oracleHome}"
  } ->

  exec { 'configure_oracle_network':
      command      => "sh netca /silent /responseFile ${path_netca}",
      path         => '/usr/bin',
      cwd          => "${oracleHome}/bin/",
      user         => 'oracle',
      timeout      =>  0
  }
}