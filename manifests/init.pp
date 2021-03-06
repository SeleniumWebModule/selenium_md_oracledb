# Class: selenium_md_oracledb
# ===========================
#
# Classe que contém o módulo para provisionamento do banco de dados oracle, versão express.
# O Objetivo do módulo é ser gerenciado pelo Selenium Web App e nunca diretamente.
# Para instalar o módulo no servidor do Selenium, fornecer os fontes da instalação 
# do oracle (oracle-xe-11.2.0-1.0.x86_64.rpm.zip)
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class {'selenium_md_oracledb':
#		oracleHome => "/opt/oradb/u01/app/oracle/product/11.2.0/dbhome_1",
#		dbname     => "banco",
#		systempass => "senha",
#	}
#
# Authors
# -------
#
# Author Name eduardo@rjconsultores.com.br
#
# Copyright
# ---------
#
# Copyright 2017 Eduardo Dicarte.
#
class selenium_md_oracledb ($oracleBaseName, $oracleVersion, $pathName, $dbname, $systempass, $sid,
		$portdb, $userdb, $passdb) {
	
		$oracleBase = "/opt/oradb/${oracleBaseName}"
		$oracleBaseApp = "${oracleBase}/app/oracle"
		$oracleHome = "${oracleBaseApp}/product/${oracleVersion}/${pathName}"
		$systemusr = "system"
			
		include selenium_md_oracledb::kernel::init		
		
		include selenium_md_oracledb::oracle::exec::environment_variables
		include selenium_md_oracledb::oracle::configure::init
		include selenium_md_oracledb::oracle::exec::dump::init
		include selenium_md_oracledb::oracle::exec::initializationdata::init
 }