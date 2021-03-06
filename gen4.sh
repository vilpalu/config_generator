#!/bin/bash
#generatorius konfiguracijos
temp="temp"
ssid_file="ssids2G"
ssid_file2="ssids5G"
begin() {
cat > temp <<EOF
{
  "wireless": {
    "countrycode": "LT",
    "scenario": "ptmp",
    "radio": [
      {
        "fragmentation": {
          "enabled": false,
          "size": 256
        },
        "ifname": "wifi0",
        "prohibited": false,
        "ieeemode": "bgn",
        "acktimeout": 100,
        "bawinsize": 64,
        "txpower": 17,
        "rts": {
          "enabled": false,
          "size": 256
        },
        "vap": [

EOF
}


add_2() {
cat >>ssids<<EOF
{
            "maxclients": 128,
            "ifname": "ath0",
            "bssid": {
              "value": "00:00:00:00:00:00",
              "enabled": false
            },
            "cwm": false,
			 "management": {
              "enabled": false,
              "tagged": false
            },
            "shortgi": true,
            "wmm": true,
            "mode": "ap",
            "minsignal": -90,
            "l2isolation": false,
            "rate": {
              "legacy": "auto",
              "mcs": "auto"
            },
            "ssid2vlan": {
EOF
}
add_5() {
cat >>ssids2<<EOF
{
            "maxclients": 128,
            "ifname": "ath1",
            "bssid": {
              "value": "00:00:00:00:00:00",
              "enabled": false
            },
            "cwm": false,
			 "management": {
             "enabled": false,
             "tagged": false
            },
            "shortgi": true,
            "wmm": true,
            "mode": "ap",
            "minsignal": -90,
            "l2isolation": false,
            "rate": {
              "legacy": "auto",
              "mcs": "auto"
            },
            "ssid2vlan": {
EOF
}
add_vap() {
echo "\"id\":" $vlan_id","  >>ssid_file
if [ "$vlan_id" = "0" ]
        then
        echo "\"enabled\": false" >>ssid_file
        echo "nera vlan"
else
		echo "\"enabled\": true" >>ssid_file
        echo "yra vlan"
fi

cat >> ssid_file<<EOF
            },
            "wds": true,
EOF

echo  "\"ssid\": \""$ssid"\",">>ssid_file
cat >> ssid_file<<EOF
            "acl": {
              "fromurl": {
                "interval": 60,
                "url": "http:\/\/",
                "autoupdate": false
              },
              "policy": "open",
              "source": "manually"
            },
            "hidden": false,
            "management": {
              "enabled": false,
              "tagged": false
            },
            "security": {
              "wpapsk": {
EOF
echo  "\"passphrase\": "\"$psw"\"">>ssid_file
cat >> ssid_file<<EOF
              },
              "mode": "wpapsk",
              "wpaenterprise": {
                "authentication": {
                  "password": "password",
                  "servers": [
                    {
                      "port": 1812,
                      "secret": "",
                      "address": "0.0.0.0"
                    }
                  ],
                  "identity": "username",
                  "eap": "ttls"
                },
                "accounting": {
                  "servers": [
                    {
                      "port": 1813,
                      "secret": "",
                      "address": "0.0.0.0"
                    }
                  ],
                  "enabled": true
                }
              },
              "wep": {
                "length": 128,
                "key": "",
                "index": 1
              }
            }
          
EOF
if [$kiek > "1"]
then
	echo "}," >>ssids
else
	echo "}">>ssids
fi
}
ghz() {
cat >>temp<<EOF
  ],
        "atpc": false,
        "channel": {
          "nonstandard": false,
          "width": 20,
          "select": "all",
          "list": [
            2412
          ]
        },
        "dfs": false,
        "enabled": true,
        "wjet": {
          "enabled": false
        },
        "amsdu": true
      },
      {
        "fragmentation": {
          "enabled": false,
          "size": 256
        },
        "ifname": "wifi1",
        "prohibited": false,
        "ieeemode": "an",
        "acktimeout": 100,
        "bawinsize": 64,
        "txpower": 17,
        "rts": {
          "enabled": false,
          "size": 256
        },
        "vap": [
EOF
}
pabaiga() {
cat>>temp<<EOF
       ],
        "atpc": false,
        "channel": {
          "select": "all",
          "extension": "upper",
          "width": 40
        },
        "dfs": true,
        "enabled": true,
        "wjet": {
          "enabled": false
        },
        "amsdu": true
      }
    ]
  },
  "services": {
    "telnet": {
      "enabled": false,
      "port": 23
    },
    "dhcpd": {
      "enabled": true,
      "leasetime": 86400,
      "prefix": 24,
      "gateway": "192.168.2.66",
      "pool": {
        "to": "192.168.2.200",
        "from": "192.168.2.101"
      }
    },
    "ntp": {
      "servers": [
        "pool.ntp.org"
      ],
      "enabled": false
    },
    "dhcp6d": {
      "enabled": false,
      "leasetime": 86400,
      "prefix": 64,
      "stateful": true,
      "pool": {
        "to": "2001::ffff",
        "from": "2001::1000"
      }
    },
    "ssh": {
      "enabled": true,
      "port": 22
    },
    "snmp": {
      "rocommunity": "public",
      "ropassword": "password",
      "rouser": "public",
      "enabled": false
    },
    "tc": {
      "managed": {
        "enabled": false,
        "profiles": [
          {
            "outgoing": {
              "speed": 2048,
              "burst": 59,
              "limited": true
            },
            "name": "Default",
            "incoming": {
              "speed": 1000,
              "burst": 50,
              "limited": false
            }
          }
        ]
      },
      "master": {
        "enabled": false,
        "profiles": [
          {
            "outgoing": {
              "speed": 2048,
              "burst": 59,
              "limited": true
            },
            "name": "Default",
            "incoming": {
              "speed": 1024,
              "burst": 50,
              "limited": false
            }
          }
        ]
      }
    },
    "wnms": {
      "host": "https:\/\/vilpalu.int.ktu.lt",
      "enabled": true
    },
    "pingwatchdog": {
      "enabled": false,
      "interval": 1,
      "failcount": 2,
      "ip": "192.168.2.66"
    },
    "ledd": {
      "enabled": true
    },
    "discovery": {
      "enabled": false
    },
    "http": {
      "enabled": true,
      "port": 80
    }
  },
  "network": {
    "router6": {
      "wan": {
        "pppoe": {
          "username": "user",
          "password": "pass",
          "dns": {
            "servers": [
              "",
              ""
            ],
            "enabled": false
          },
          "mtu": 1492
        },
        "mode": "static",
        "static": {
          "gateway": "fc00::c0:a8:2:1",
          "dns": {
            "servers": [
              "",
              ""
            ]
          },
          "ip": [
            {
              "prefix": 64,
              "ip": "fc00::c0:a8:2:42"
            }
          ]
        },
        "dynamic": {
          "stateful": true,
          "dns": {
            "servers": [
              "",
              ""
            ],
            "enabled": false
          },
          "prefixdelegation": false
        }
      },
      "lan": {
        "ip": {
          "prefix": 64,
          "ip": "fc00:1::c0:a8:2:42"
        }
      }
    },
    "router": {
      "wan": {
        "pppoe": {
          "username": "user",
          "password": "pass",
          "dns": {
            "servers": [
              "",
              ""
            ],
            "enabled": false
          },
          "mtu": 1492
        },
        "mode": "dynamic",
        "static": {
          "gateway": "192.168.3.1",
          "dns": {
            "servers": [
              "",
              ""
            ]
          },
          "ip": [
            {
              "prefix": 24,
              "ip": "192.168.3.100"
            }
          ]
        },
        "dynamic": {
          "gateway": "192.168.3.1",
          "fallback": true,
          "dns": {
            "servers": [
              "",
              ""
            ],
            "enabled": false
          },
          "ip": [
            {
              "prefix": 24,
              "ip": "192.168.3.100"
            }
          ]
        }
      },
      "secondary": {
        "enabled": false,
        "ip": {
          "prefix": 24,
          "ip": "192.168.2.250"
        }
      },
      "lan": {
        "ip": {
          "prefix": 24,
          "ip": "192.168.2.66"
        }
      }
    },
    "topology": "bridge",
    "bridge": {
      "management": {
        "dynamic": {
          "gateway": "192.168.2.1",
          "fallback": true,
          "dns": {
            "servers": [
              "",
              ""
            ],
            "enabled": false
          },
          "ip": [
            {
              "prefix": 24,
              "ip": "192.168.2.66"
            }
          ]
        },
        "static": {
          "gateway": "192.168.2.1",
          "dns": {
            "servers": [
              "",
              ""
            ]
          },
          "ip": [
            {
              "prefix": 24,
              "ip": "192.168.2.66"
            }
          ]
        },
        "mode": "dynamic",
        "secondary": {
          "enabled": false,
          "ip": {
            "prefix": 24,
            "ip": "192.168.1.100"
          }
        }
      },
      "ipv6": false,
      "vlan": {
        "id": 2,
        "enabled": false
      },
      "management6": {
        "mode": "dynamic",
        "static": {
          "gateway": "2000::1",
          "dns": {
            "servers": [
              "",
              ""
            ]
          },
          "ip": [
            {
              "prefix": 64,
              "ip": "2000::66"
            }
          ]
        },
        "dynamic": {
          "stateful": false,
          "dns": {
            "servers": [
              "",
              ""
            ],
            "enabled": false
          }
        }
      }
    },
    "ethernet": {
      "eth0": {
        "enabled": true
      },
      "eth1": {
        "enabled": true
      }
    },
    "nat": true
  },
  "system": {
    "log": {
      "level": "debug"
    },
    "users": [
      {
        "password": "oHSl3yqR.t1uQ",
        "name": "admin",
        "home": "\/data",
        "agreement": true
      },
      {
        "password": "*",
        "uid": 1,
        "home": "\/var\/run\/openntpd",
        "gid": 65534,
        "name": "_ntp",
        "shell": "\/bin\/false"
      }
    ],
    "date": {
      "date": "01\/07\/2014",
      "time": "00:00",
      "timezone": "UTC"
    },
    "publicstatus": {
      "enabled": true
    },
    "device": {
      "contact": "Contact",
      "name": "testuojamas",
      "coordinate": {
        "longitude": 0,
        "latitude": 0
      },
      "firmwareid": "AP.QD-1",
      "location": "Device location"
    },
    "poe": {
      "enabled": false
    }
  }
}
EOF
}

add_vap2() {
echo "\"id\":" $vlan_id","  >>temp
cat >> temp<<EOF
 "enabled": true
            },
            "wds": true,
EOF

echo  "\"ssid\": \""$ssid"\",">>temp
cat >>temp<< EOF
            "rate": {
              "legacy": "auto",
              "mcs": "auto"
            },
            "hidden": false,
            "cwm": false,
            "security": {
              "wpapsk": {
                "passphrase": "slaptazodis"
              },
              "mode": "wpaenterprise",
              "wpaenterprise": {
                "authentication": {
                  "eap": "ttls",
                  "password": "password",
                  "identity": "username",
                  "servers": [
                    {
                      "port": 1812,
EOF
echo  "\"secret\": \""$secret"\",">>temp
echo  "\"address\": \""$radius"\"">>temp
cat >>temp<<EOF
                    }
                  ]
                },
                "accounting": {
                  "servers": [
                    {
                      "port": 1813,
EOF
echo  "\"secret\": \""$secret"\",">>temp
echo  "\"address\": \""$radius"\"">>temp
cat >>temp<<EOF
                    }
                  ],
                  "enabled": true
                }
              },
              "wep": {
                "length": 128,
                "key": "",
                "index": 1
              }
            }
          }
EOF
}
add_vap_open() {
echo "\"id\":" $vlan_id","  >>ssids
if [ "$vlan_id" = "0" ]
        then
        echo "\"enabled\": false" >>ssids
        echo "nera vlan"
else
	echo "\"enabled\": true" >>ssids
        echo "yra vlan"
fi

cat >> ssids<<EOF
            },
            "wds": true,
EOF

echo  "\"ssid\": \""$ssid"\",">>ssids
cat >> ssids<<EOF
            "acl": {
              "fromurl": {
                "interval": 60,
                "url": "http:\/\/",
                "autoupdate": false
              },
              "policy": "open",
              "source": "manually"
            },
            "hidden": false,
            "management": {
              "enabled": false,
              "tagged": false
            },
            "security": {
              "wpapsk": {
				"passphrase": "testasasdasda"
              },
              "mode": "open",
              "wpaenterprise": {
                "authentication": {
                  "password": "password",
                  "servers": [
                    {
                      "port": 1812,
                      "secret": "",
                      "address": "0.0.0.0"
                    }
                  ],
                  "identity": "username",
                  "eap": "ttls"
                },
                "accounting": {
                  "servers": [
                    {
                      "port": 1813,
                      "secret": "",
                      "address": "0.0.0.0"
                    }
                  ],
                  "enabled": true
                }
              },
              "wep": {
                "length": 128,
                "key": "",
                "index": 1
              }
            }
EOF
if [$kiek > "1"]
then
	echo "}," >>ssids
else
	echo "}">>ssids
fi
}
#-----------------------------main
rm temp
echo "iveskite ssid kieki:"
read kiekis
let kiekis++
		begin
		add_2
while [ $kiek -lt $kiekis];
do
	echo "SSID:" "$kiek"
	echo "irasykite tinklo pavadinima"
	read ssid
	echo " saugos rezimo pasirinkimas:"
	echo "[1] WPA-SPK"
	echo "[2] WPA-ENTERPRICE(802.1x)"
	echo "[3] Open"
	read pasirinkimas
	if [ "$pasirinkimas" = "1" ]
	then
		echo "pasirinkote WPA-SPK rezima"
		echo "irasykite vlan, jei ne rasykite 0"
		read vlan_id
		echo "irasykite tinklo slaptazodi"
		read psw
		add_vap
		add_vap
	elif [ "$pasirinkimas" = "2" ]
	then
		echo "pasirinkote WPA-ENTERPRICE(802.1x) rezima"
		echo "irasykite vlan id"
		read vlan_id
		echo "irasykite RADIUS serverio IP adresa"
		read radius
		echo "irasykite RADIUS serverio slaptazodi"
		read secret
		add_vap2
		ghz
		add_5
		add_vap2
	elif [ "$pasirinkimas" = "3" ]
	then
		echo "pasirinkote Open rezima"
		echo "irasykite vlan, jei ne rasykite 0"
		read vlan_id	
		add_vap_open
		ghz
		add_5
		add_vap_open
	else
		echo "tokio pasirinkimo nera"
	fi
	let kiek++
done	
cat $ssid_file>>temp
ghz
add_5
cat $ssid_file2>>temp
cat $ssid_file>>temp
pabaiga
mv temp $ssid.txt

