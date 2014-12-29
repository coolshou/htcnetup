#!/bin/bash
#
#htcnet.sh
#LuoXiaoqiu <qilvilu@gmail.com>
#An activater for HTC android phone Internet pass-through.
#

#PC's internet interface
pc_internet_device="eth0"
#phone's connection  interface in pc
phone_usb_device="usb0"

logger "###### 1: $1 ######################## 2: $2 ##########################"

do_remove=0
case "$1" in 
	"--remove")
	do_remove=1; 
	shift;
	;;
	"--add")
	logger "############################## arg2: $2"

	;;
esac

get_ip ()
{
    arp -n | grep $phone_usb_device | awk '{print $1}'
}
exit

case "$do_remove" in
  0)
  #add net share
	sudo sysctl -w net.ipv4.ip_forward=1
	sudo iptables -t nat -A POSTROUTING -o $pc_internet_device -j MASQUERADE
	sudo iptables -t nat -A PREROUTING -i $phone_usb_device -p udp -m udp --dport 53 -j DNAT --to-destination 8.8.8.8:53
	#TODO: This needs a timeout and loop needs cleaning up, but works fine and borrowed from another post.
	logger "waiting for IP on computer usb"
	while [[ `get_ip` < 192 ]];do sleep 2; done
	phoneip=`get_ip`
	logger "IP adress is $phoneip "

	#run activater process
	htcnetup $phoneip
	#echo -n -e "\x00\x02\x00\x00" | nc -q 2 $phoneip 6000 > /dev/null
  ;;
  1)
  #remove net share

  ;;
esac
