#!/usr/bin/perl
# 040318OR
# configs für rum archiv system

package config;

$vorlauf= 1;                                           # Minuten vorher wird eine Mail abgeschickt
$nachlauf = 2;                                         # Minuten danach noch Zeit lassen (nach Beginn zum Anlegen und nach Ende zum Update)
                                                       #       bis Eintrag ins Audioport
$podvorlauf = 2;				       # Minuten bevor Eintrag in Automat vor dem Abspielen eines Podcastbeitrags erfolgt
$abschneiden=37;                                       # Sekunden, die vorne abgeschnitten werden, um Ueberlappungen zu vermeiden
$aufnahme_offset=0;                                    # Sekunden, die hinten abgeschnitten werden
$bloecke= 60;                                          # Standardaufnahmelaenge in Minuten
$mp3pfad="/data/mp3";                                  # pfad zu den mp3 im Archiv
$mp3tmp="/data/temp";
$audioportal = "http://jukebox/radiowebportal/portal"; # Audioportal Link lokal/intern 
$rumtmp = "/data/temp";             
$rumlog = "/data/log/mail-agent.log";             
$rumstream = "http://jukebox:8000/ring";               # wo kommt unser Radiosignal her?
$streamripper = "Streamripper_rips";                   # Unterverzeichnis in dem Streamripper speichert
$streamripper_prog = "/usr/bin/streamripper"		# Streamripper-Binary
$poddir = "POD";                                       # Unterverzeichnis in dem Podget speichert
$rumplayenv = "/var/service/rum-player/env";           # wo ist das Env vom Rum-Player?
$rumplaypipe= "/data/temp/rum-player-cmd.pipe";        # Pipe zur Übergabe an den Rum-Player
                         
$mysql_db_server="localhost";
$mysql_db_user="radio";
$mysql_db_password="radio";
$mysql_db_name="radionet";

$rumstream_format="mp3";

