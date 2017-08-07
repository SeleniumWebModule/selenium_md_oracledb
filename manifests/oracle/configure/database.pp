class selenium_md_oracledb::oracle::configure::database {
  require selenium_md_oracledb::oracle::configure::network

  $path_rsp = "/opt/oradb/database/response"
  $path_dbca  = "${path_rsp}/dbca.rsp"

  $oracleVersion = $selenium_md_oracledb::oracleVersion
  $dbname = $selenium_md_oracledb::dbname
  $sid = $selenium_md_oracledb::sid
  $systempass = $selenium_md_oracledb::systempass
  

  file {'dbca.rsp':
      ensure => file,
      path    => "${path_dbca}",
      content => template("selenium_md_oracledb/dbca.rsp.erb")
  } -> 

  exec {'install_oracle_database':
      command      => "sh dbca -silent -createDatabase -responseFile ${path_dbca}",
      cwd          => "${selenium_md_oracledb::oracleHome}/bin/",
      path         =>  "/usr/bin",
      user         => 'oracle',
      timeout      =>  0,
      unless       => "test -d $selenium_md_oracledb::oracleBaseApp/admin/${selenium_md_oracledb::dbname}"
  } 
}