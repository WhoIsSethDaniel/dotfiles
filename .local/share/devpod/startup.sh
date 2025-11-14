#!/bin/bash

echo "RUNNING devpod state sync"
scp "$HOME"/.inputrc mmwebsite:.
scp "$HOME"/.psqlrc mmwebsite:.
scp "$HOME"/.ripgreprc mmwebsite:.
cp-file.sh /usr/local/share/GeoIP/GeoIP2-City.mmdb
cp-file.sh /usr/local/share/GeoIP/GeoIP2-ISP.mmdb
