#!/bin/bash
#################################################
# A simple traffic logger under the MIT license #
#################################################

function usage {
	echo "usage: log_traffic.sh INTERFACE (e.x. eth0) INTERVAL_IN_SECONDS (e.x. 1) OPTIONAL:DATE_FORMAT (e.x. +%Y-%m-%d, default=Unix Timestamp)"
}
if [ "$1" = "" ]; then
	usage
	exit 1
elif [ "$2" = "" ]; then
	usage
	exit 1
fi

if [ "$3" = "" ]; then
	DATEFORM="+%s"
else
	DATEFORM=$3
fi
	
IFACE="$1";
INTERVAL="$2"
echo "TIME;RX;TX"
while : true
do
	TIME=$(date "$DATEFORM");
	RX=$(ifconfig "$IFACE" | grep bytes | grep "RX" | awk '{ print $5 }');
	TX=$(ifconfig "$IFACE" | grep bytes | grep "TX" | awk '{ print $5 }');
	echo "$TIME;$RX;$TX"
sleep "$INTERVAL"
done
