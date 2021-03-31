#!/bin/bash

PATHSEP=":"
if [[ $OS == "Windows_NT" ]] || [[ $OSTYPE == "cygwin" ]]
then
    PATHSEP=";"
fi

javac -cp "./www/WEB-INF/lib/org.json.jar${PATHSEP}winstone.jar${PATHSEP}./www/WEB-INF/classes/" www/WEB-INF/classes/se/yrgo/schedule/*/*.java && java -jar winstone.jar --webroot=www

