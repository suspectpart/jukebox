#!/bin/sh

adjustSourcesFile()
{
	echo deb http://www.debian-multimedia.org lenny main >> /etc/apt/sources.list
}

createDirectories()
{
	mkdir /opt/jukebox
	useradd -d /opt/jukebox jukebox
	chown jukebox /opt/jukebox
	cp -r packages /opt/jukebox/packages
	cd /opt/jukebox
}

getPackages()
{
	wget http://bl0rg.net/~neingeist/querfunk/jukebox-packages-20090124/php-html-progress_1.2.6-1_all.deb
	wget http://bl0rg.net/~neingeist/querfunk/jukebox-packages-20090124/mixplayd/mixplayd_0.60-2+jukebox_i386.deb
	wget http://bl0rg.net/~neingeist/querfunk/jukebox-packages-20090124/alsa-lib/libasound2_1.0.16-2+jukebox_i386.deb
	wget http://www.debian-multimedia.org/pool/main/d/debian-multimedia-keyring/debian-multimedia-keyring_2010.12.26_all.deb
	wget http://bl0rg.net/~neingeist/querfunk/jukebox-packages-20090124/alsa-lib/lib64asound2_1.0.16-2+jukebox_i386.deb
	wget http://bl0rg.net/~neingeist/querfunk/jukebox-packages-20090124/darkice_0.19-1+jukebox_i386.deb
	wget http://bl0rg.net/~neingeist/querfunk/jukebox-packages-20090124/alsa-lib/libasound2-doc_1.0.16-2+jukebox_all.deb
	wget http://ftp.de.debian.org/debian/pool/contrib/l/liveice/liveice_1.0-3_i386.deb
	wget http://bl0rg.net/~neingeist/querfunk/jukebox-packages-20090124/jukebox-deps_200901-1_i386.deb
}

installPackages()
{
	apt-get install php5-cli php5-common php-pear php-html-common
	dpkg -i packages/php-html-progress_1.2.6-1_all.deb
	apt-get install openssl ca-certificates libvorbisenc2 libspeex1 libflac8 libcurl3-gnutls libao2 libmad0 libid3tag0 esound-common libaudiofile0 esound-clients libesd0 libogg0 libvorbis0a libvorbisfile3 madplay vorbis-tools
	dpkg -i packages/mixplayd_0.60-2+jukebox_i386.deb
	dpkg -i packages/libasound2_1.0.16-2+jukebox_i386.deb
	dpkg -i packages/debian-multimedia-keyring_2010.12.26_all.deb
	apt-get update 
	apt-get install libc6-amd64 libfreebob0 libmp3lame0 libtwolame0 libavc1394-0 libiec61883-0 libraw1394-8 libjack0
	dpkg -i packages/lib64asound2_1.0.16-2+jukebox_i386.deb
	dpkg -i packages/darkice_0.19-1+jukebox_i386.deb
	dpkg -i packages/libasound2-doc_1.0.16-2+jukebox_all.deb
	dpkg -i packages/liveice_1.0-3_i386.deb
	apt-get install subversion alsaplayer alsaplayer-alsa alsaplayer-text phpmyadmin sudo mysql-server-5.0 
					apache2 libapache2-mod-php5 php5-mysql php5-gd lame streamripper icecast2 ices2 libwww-perl 
					daemontools-run libglib2.0-0 libmikmod2 libsndfile1 daemontools libtheora0 libxslt1.1 libshout3 
					apache2.2-common php5-common liburi-perl libhtml-parser-perl libhtml-tree-perl libhtml-tagset-perl 
					mysql-client-5.0 libdbi-perl libmysqlclient15off psmisc libfreetype6 libgd2-xpm libjpeg62 libpng12-0 
					libt1-5 libxpm4 libmysqlclient15off libglib2.0-0 libtre4 libsvn1 libapr1 libaprutil1 apache2-utils 
					libplrpc-perl libfontconfig1 php5-common php5-mcrypt libmcrypt4 libltdl3 mysql-common libdbd-mysql-perl 
					libserf-0-0 libneon27-gnutls libnet-daemon-perl fontconfig-config libexpat1 libpq5 libexpat1 php5-common 
					ttf-dejavu ttf-bitstream-vera ttf-freefont gsfonts-x11 ttf-dejavu-core ttf-dejavu-extra defoma gsfonts
					xfonts-utils libfontenc1 libxfont1 xfonts-encodings apache2-mpm-prefork
}

adjustSourcesFile
createDirectories
installPackages