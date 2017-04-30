#!/bin/sh
torerodir=`dirname $0`;
java -jar $torerodir/torero.jar $1 $2 >> $torerodir/torero.log 2>&1
