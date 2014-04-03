Debian-Installation
===================
Debian 7.4:

* Rechnername: jukebox
* Domain: bermudafunk.org
* Root-PW: leer	(-> sudo wird automatisch installiert)
* Ersten Benutzer einrichten (Admin per Sudo)
* Partitionierung: "geführt", verschiedene Partitionen für /var, /home usw.

Ansonsten: Standard-Einstellung

Software-Auswahl (mit tasksel):
* Web Server
* Mail server
* SSH server
* Standard-Systemwerkzeuge

System-Start, Login
-----

* /tmp-Verzeichnis nicht löschen und beschädigte Dateisysteme beim Booten automatisch Reparieren:
in `/etc/default/rcS` eintragen:
`TMPTIME=-1`
`FSCKFIX=yes`

VIM einrichten (optional)
-----
`sudo apt-get install vim`  
`sudo update-alternatives --config editor`  

Automatische Updates (optional)
--------------------
`sudo apt-get install cron-apt`


User Jukebox anlegen
====================
`sudo mkdir /opt/jukebox`  
`sudo useradd -Gaudio -d /opt/jukebox jukebox`  
`sudo chown jukebox /opt/jukebox`  
`sudo chown jukebox /opt/jukebox`  
`sudo ln -s /opt/jukebox /home/jukebox`  
\#`sudo mkdir /opt/jukebox_install`  

Git-Repo klonen
===============

`sudo apt-get install git`  
`git clone https://github.com/suspectpart/jukebox``

ALSA installieren
=================
`sudo apt-get install alsaplayer-alsa alsaplayer-text alsa-utils`  
`sudo cp -i jukebox/conf/asound/asound.conf /etc/`

Alsa-lib Patch
--------------
* Paket installieren:
`sudo dpkg -i sudo dpkg -i jukebox/packages/wheezy/libasound2_1.0.25-4_i386.deb`

* Oder: Paket selbst patchen und erzeugen:
`sudo apt-get install dpkg-dev autotools-dev debhelper dh-autoreconf doxygen python-dev` (>600MB Download!)
`apt-get source alsa-lib`
`cd alsa-lib-1.0.25/`
`patch -p1 </opt/jukebox/src/alsa-lib-patch_pcm_stdout/alsalib-stdout-file-1.0.23.diff`
`dpkg-source commit`
`dpkg-buildpackage`
`sudo dpkg -i ../libasound2_1.0.25-4_i386.deb`

Test
-----
`alsaplayer -i text -d stdout -q http://streaming.fueralle.org:8000/bermudafunk.ogg` (Schreibt auf die Konsole)

Sound-Hardware anzeigen:
-----
`cat /proc/asound/cards`  
`cat /proc/asound/pcm`  
`aplay -l`  


Jukebox-Pakete installieren
===========================

`sudo apt-get install php5-cli php5-common php-pear php-html-common php5-mysql`  
`sudo dpkg -i jukebox/packages/neingeist/php-html-progress_1.2.6-1_all.deb`  

`sudo apt-get install php5-cli php5-common php-pear php-html-common`  
`sudo dpkg -i jukebox/packages/neingeist/mixplayd/mixplayd_0.60-2+jukebox_i386.deb`

''contrib''-Pakete hinzufügen:
-----
`sudo sed -i "s/main/main contrib/" /etc/apt/sources.list && sudo apt-get update`

Paket `liveice` herunterladen und installieren:
-----
`wget http://archive.debian.org/debian/pool/contrib/l/liveice/liveice_1.0-3_i386.deb && sudo dpkg -i liveice_1.0-3_i386.deb`

\#`sudo apt-get install libjack0 libmp3lame0 libtwolame0`  
\#`sudo dpkg -i jukebox/packages/neingeist/darkice_0.19-1+jukebox_i386.deb`  
`sudo apt-get install darkice libmp3lame0`


Jukebox-Repository
==================
`sudo apt-get install subversion`  
`cd /opt && sudo svn co svn://tools.janguo.de/jukebox`

`sudo cp -vi jukebox/conf/sudo/jukebox /etc/sudoers.d`

Apache Webserver
================
`sudo cp -vi jukebox/conf/apache/jukebox /etc/apache2/conf.d/`  
`sudo ln -s /etc/apache2/mods-available/expires.load /etc/apache2/mods-enabled/`  

`sudo patch /etc/php5/cli/php.ini <jukebox/config/php/cli/php.ini.patch`  
`sudo patch /etc/php5/apache2/php.ini <jukebox/conf/php/apache2/php.ini.patch`

`sudo service apache2 restart`

MySQL-Datenbanken
=================
`sudo apt-get install mysql-client mysql-server`

Root-Passwort festlegen

Datenbanken und MySQL-User anlegen
-----
mysql -u root -p  
Enter password:  

CREATE DATABASE radionet;  
GRANT ALL PRIVILEGES ON *.* TO radio@localhost IDENTIFIED BY 'radio' WITH GRANT OPTION;  
CREATE DATABASE intranet;  
GRANT ALL PRIVILEGES ON *.* TO webcalendar@localhost IDENTIFIED BY 'webcal01' WITH GRANT OPTION;  
FLUSH PRIVILEGES;  
QUIT;  
Bye

Datenbanken herunterladen:
-----
`ftp -p ftp.bermudafunk.org`  
Name:  
Password:  
`get intranet.sql`  
`get radionet.sql`

Datenbanken einlesen
-----
mysql -u root -p intranet <intranet.sql  
mysql -u root -p radionet <radionet.sql  

User `jukebox` anlegen
-----
ToDo

Procmailrc
==========
ToDo

NTP (Uhrzeit)
=============
sudo apt-get install ntp

PmWiki
======
`sudo chown -R www-data /opt/jukebox/www/pmwiki`

WebCalendar
===========
Download von [http://www.k5n.us/webcalendar.php?topic=Download]  
`wget https://sourceforge.net/projects/webcalendar/files/webcalendar%201.2/1.2.7/WebCalendar-1.2.7.tar.gz/download -O WebCalendar-1.2.7.tar.gz`

`sudo -u jukebox tar -xzf WebCalendar-1.2.7.tar.gz --directory /opt/jukebox/www/`  
`sudo rm /opt/jukebox/www/webcalendar`  
`sudo -u jukebox ln -s /opt/jukebox/www/WebCalendar-1.2.7/ /opt/jukebox/www/webcalendar`  
`sudo chown -R www-data /opt/jukebox/www/webcalendar`  

`sudo -u jukebox cp -vi jukebox/bin/config.pm /opt/jukebox/bin/`

WebCalendar konfigurieren
-----
* [http://jukebox] -> Sendeplan im Browser aufrufen
* Admin-Passwort setzen
* Login mit Admin-Passwort
* Database Settings:
  * Database Type:	MySQL (Improved)
  * Server:	localhost
  * Login:	webcalendar
  * Password:	webcal01
  * Database Name:	intranet
  * Database Cache Directory:	/tmp
* Update Database
* Timezone Conversion: Convert Data go GMT
* Application Settings:
  * Create Default Admin Account:	[ ]
  * Application Name:	WebCalendar
  * Server URL:	http://jukebox/webcalendar
  * User Authentication:	Web-based via WebCalendar (default)
  * Read-Only:	No
  * Environment:	Production
* Save Settings

Jukebox-Crontab
------
`sudo -u jukebox crontab -e`  
`* * * * * cd /opt/jukebox/www/webcalendar/tools/ && php send_reminders.php`



PEAR
====
Vermutlich unnötig

Live-Erkennung
==============
ToDo

ToDo
====
* Live-Erkennung
* Binaries in ''/home/jukebox/bin/'' sind (teilweise) in ''mail-agent.pl'' hartkodiert, evtl. durch symbolische Links auf die Binaries in Debian-Paketen lösen (streamripper, mixplayd usw.).
* Services [http://wiki.bermudafunk.de/doku.php/stream#einleitung]

