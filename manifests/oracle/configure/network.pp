class selenium_md_oracledb::oracle::configure::network {
  require selenium_md_oracledb::oracle::install::doinstall

  $path_rsp = "/opt/oradb/database/response"
	$path_netca = "${path_rsp}/netca.rsp"
	
	file {'netca.rsp':
    	ensure  => file,
    	path    => $path_netca,
    	content => template("selenium_md_oracledb/netca.rsp.erb"),
    	ignore => "ls ${selenium_md_oracledb::oracleHome}"
  } ->

  exec { 'configure_oracle_network':
      command      => "sh netca /silent /responseFile ${path_netca}",
      cwd          => "${selenium_md_oracledb::oracleHome}/bin/",
      path         =>  "/usr/bin",
      user         => 'oracle',
      timeout      =>  0,
      unless       => "test -e ${selenium_md_oracledb::oracleHome}/network/admin/tnsnames.ora"
  }
}