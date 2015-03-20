#!/bin/bash

ADB="adb"
WLAN_IFACE="wlan0"
IP=`$ADB shell "ifconfig $WLAN_IFACE 2>/dev/null" | awk '{print $3}'`
if [ "$IP" == "" ]; then
    echo "Empty IP detected, exiting"
    exit 1
fi

echo "Setting device to TCP mode"
$ADB tcpip 5555

echo "Waiting a while for adb to restart on device..."
sleep 2

echo "Connecting over TCP"
$ADB connect $IP

echo "Return to USB by running '$ADB usb'"