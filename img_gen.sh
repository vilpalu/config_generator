#!/bin/bash
#openwrt image generator script
CERT_GEN="/etc/openvpn/easy-rsa"
KEY_GEN="/etc/openvpn/easy-rsa/keys"
CERT_NAME="ca.crt"
CLIENT_CA="client.crt"
KEY="ta.key"
OPENVPN_PATH="/home/vilpalu/op/openwrt/files/etc/openvpn"
MAKE_DIR="/home/vilpalu/op/openwrt/"
CCD_DIR="/etc/openvpn/ccd"
IMG="/home/vilpalu/op/openwrt/bin/ar71xx/openwrt-15.05-rc2-ar71xx-generic-tl-wdr4300-v1-squashfs-factory.bin"

cert_gen() {
	cd $CERT_GEN
	. ./vars
	./build-key --batch $DEV_NAME
	cat > $CCD_DIR/$DEV_NAME <<EOF
		ifconfig-push 10.10.0.30  10.10.0.31
EOF
echo "sertifikatai sugeneruoti"
}

copy() {
	cp $KEY_GEN/$DEV_NAME.crt   $OPENVPN_PATH/$CLIENT_CA
	cp $KEY_GEN/$DEV_NAME.key   $OPENVPN_PATH/$KEY
	echo "sertifikatai nukopijuoti"
}

cleanup () {
	cd $MAKE_DIR 
	make clean
	rm $OPENVPN_PATH/$CLIENT_CA
	rm $OPENVPN_PATH/$KEY
	echo "valymas baigtas"
}

img_gen() {
	cd $MAKE_DIR
	make image PROFILE=TLWDR4300 PACKAGES="openwisp-fw snmpd  -wpad-mini" FILES=files/
	mv $IMG $MAKE_DIR/$DEV_NAME.bin
	echo "sugeneruota"
}

#begin
echo "irasykite irenginio varda"
read DEV_NAME
cleanup
if [ ! -f $KEY_GEN/$DEV_NAME.crt ]; then
	cert_gen
fi
copy
img_gen