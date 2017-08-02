class selenium_md_oracledb::oracle::configure::database {
  require selenium_md_oracledb::oracle::configure::network

  $path_rsp = "/opt/oradb/database/response"
  $path_dbca  = "${path_rsp}/dbca.rsp"
  $oracleHome = "/opt/oradb/u01/app/oracle/product/11.2.0/dbhome_1"

  file {'dbca.rsp':
      ensure => file,
      path    => "${path_dbca}",
      content => template("selenium_md_oracledb/dbca.rsp.erb"),
      ignore => "ls ${oracleHome}"
  } -> 

  exec {'install_oracle_database':
      command      => "sh dbca -silent -createDatabase -responseFile ${path_dbca}",
      user         => 'oracle',
      cwd          => "${oracleHome}/bin",
      path         => '/usr/bin',
      timeout      => 0
  }
}