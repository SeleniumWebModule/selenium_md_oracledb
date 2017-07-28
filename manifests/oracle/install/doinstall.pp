class selenium_md_oracledb::oracle::install::doinstall {
  require selenium_md_oracledb::oracle::install::prepare

	$path_respfile = "/opt/oradb/database/response/db_install.rsp"
	
	file {'db_install.rsp':
    	ensure  => file,
    	path    => '/opt/oradb/database/response/db_install.rsp',
    	content => template("selenium_md_oracledb/db_install.rsp.erb"),
    	ignore => 'ls /opt/oradb/u01/'
  	} ->

  	exec { 'installer_oradb':
  		command      => "sh runInstaller -ignorePrereq -silent -responseFile ${path_respfile}",
  		path        => '/usr/bin',
  		cwd         => '/opt/oradb/database',
  		user        => 'oracle',
  		unless      => 'ls /opt/oradb/u01/'
  	} 
}