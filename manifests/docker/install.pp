class selenium_md_oracledb::docker::install {
	class {'docker':} ->

	vcsrepo { '/tmp/docker_images':
    	ensure   => present,
    	provider => git,
    	remote   => 'origin',
   		source   => {'origin' => 'https://github.com/oracle/docker-images.git'},
  	} ->

  package {'unzip':
		ensure => present
	} ->

  exec {'copy_arquive_to_install':
		command => 'cp *.zip /tmp/',
		user => 'root',
		group => 'root',
		path => '/usr/bin',
		cwd => '/vagrant/pkg'
	} ->

  exec {'build_image_oracledb':
  		command => "sh buildDockerImage.sh -v 11.2.0.2 -x",
  		user    => 'root',
  		group   => 'root',
  		cwd     => '/tmp/docker_images/OracleDatabase/dockerfiles',
  		path    => '/usr/bin/',
  		timeout => 0
  	}
}