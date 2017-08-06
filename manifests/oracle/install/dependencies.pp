class selenium_md_oracledb::oracle::install::dependencies {
	$install = [ 'binutils.x86_64', 'compat-libstdc++-33.x86_64', 'glibc.x86_64','ksh.x86_64','libaio.x86_64',
             'libgcc.x86_64', 'libstdc++.x86_64', 'make.x86_64','compat-libcap1.x86_64', 'gcc.x86_64', 'vim',
             'gcc-c++.x86_64','glibc-devel.x86_64','libaio-devel.x86_64','libstdc++-devel.x86_64', 'net-tools',
             'sysstat.x86_64','unixODBC-devel','glibc.i686','libXext.x86_64','libXtst.x86_64','unzip']

 	package { $install:
	  ensure  => present,
	}    

	#Oracle exige esses arquivos, não sei pra que :(
	exec { 'install_x_window_system':
		command     => 'yum groupinstall "X Window System" -y',
		path        => '/bin',
		user        => 'root',
		group       => 'root',
		timeout     => 0,
		unless      => "ls ${selenium_md_oracledb::oracleHome}",
	}         
}