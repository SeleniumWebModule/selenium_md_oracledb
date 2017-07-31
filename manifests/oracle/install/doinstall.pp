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
      before      => Exec['configure_oracle_network'],
  		unless      => 'ls /opt/oradb/u01/',
  	} 

    ->

    file {'netca.rsp':
      ensure  => file,
      path    => '/opt/oradb/database/response/netca.rsp',
      content => template("selenium_md_oracledb/netca.rsp.erb"),
      ignore => 'ls /opt/oradb/u01/'
    } ->

    #não da certo!!!! - Criar um script que aguarde o final da instalação, 
    #ou alterar o runinstaller
    exec { 'configure_oracle_network':
        command      => "sh netca /silent /responseFile ${path_respfile}",
        path         => '/usr/bin',
        cwd          => '/opt/oradb/u01/app/oracle/product/11.2.0/dbhome_1/bin/',
        user         => 'oracle',
        unless       => 'ls /opt/oradb/u01/'
      }
}