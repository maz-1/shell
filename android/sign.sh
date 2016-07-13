#!/bin/sh
rm -f /tmp/tmp.apk
proxychains jarsigner -verbose -keystore /opt/android-stuff/android.keystore -storepass ********** -digestalg SHA1 -sigalg MD5withRSA -tsa https://timestamp.geotrust.com/tsa -signedjar  $2  $1   android
#zipalign 4 /tmp/tmp.apk $2
