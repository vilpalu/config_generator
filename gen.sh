#!/bin/bash
#generatorius konfiguracijos
echo "irasykite tinklo pavadinima"
read ssid

echo "irasykite vlan, jei ne rasykite "

read vlan_id

echo "irasykite tinklo slaptazodi"

read psw



cat > temp <<EOF
{

  "network": {

    "router": {

      "wan": {

        "pppoe": {

          "mtu": 1492,

          "dns": {

            "servers": [

              "",

              ""

            ],

            "enabled": false

          },

          "password": "pass",

          "username": "user"

        },

        "dynamic": {

          "ip": [

            {

              "ip": "192.168.3.100",

              "prefix": 24

            }

          ],

          "dns": {

            "servers": [

              "",

              ""

            ],

            "enabled": false

          },

          "fallback": true,

          "gateway": "192.168.3.1"

        },

        "mode": "dynamic",

        "static": {

          "ip": [

            {

              "ip": "192.168.3.100",

              "prefix": 24

            }

          ],

          "gateway": "192.168.3.1",

          "dns": {

            "servers": [

              "",

              ""

            ]

          }

        }

      },

      "secondary": {

        "ip": {

          "ip": "192.168.2.250",

          "prefix": 24

        },

        "enabled": false

      },

      "lan": {

        "ip": {

          "ip": "192.168.2.66",

          "prefix": 24

        }

      }

    },

    "topology": "bridge",

    "router6": {

      "wan": {

        "pppoe": {

          "mtu": 1492,

          "dns": {

            "servers": [

              "",

              ""

            ],

            "enabled": false

          },

          "password": "pass",

          "username": "user"

        },

        "dynamic": {

          "dns": {

            "servers": [

              "",

              ""

            ],

            "enabled": false

          },

          "prefixdelegation": false,

          "stateful": true

        },

        "mode": "static",

        "static": {

          "ip": [

            {

              "ip": "fc00::c0:a8:2:42",

              "prefix": 64

            }

          ],

          "gateway": "fc00::c0:a8:2:1",

          "dns": {

            "servers": [

              "",

              ""

            ]

          }

        }

      },

      "lan": {

        "ip": {

          "ip": "fc00:1::c0:a8:2:42",

          "prefix": 64

        }

      }

    },

    "ethernet": {

      "eth1": {

        "enabled": true

      },

      "eth0": {

        "enabled": true

      }

    },

    "nat": true,

    "bridge": {

      "management6": {

        "mode": "dynamic",

        "dynamic": {

          "stateful": false,

          "dns": {

            "servers": [

              "",

              ""

            ],

            "enabled": false

          }

        },

        "static": {

          "ip": [

            {

              "ip": "2000::66",

              "prefix": 64

            }

          ],

          "gateway": "2000::1",

          "dns": {

            "servers": [

              "",

              ""

            ]

          }

        }

      },

      "vlan": {

        "id": 2,

        "enabled": false

      },

      "ipv6": true,

      "management": {

        "mode": "dynamic",

        "dynamic": {

          "ip": [

            {

              "ip": "192.168.2.66",

              "prefix": 24

            }

          ],

          "dns": {

            "servers": [

              "",

              ""

            ],

            "enabled": false

          },

          "fallback": true,

          "gateway": "192.168.2.1"

        },

        "secondary": {

          "ip": {

            "ip": "192.168.1.100",

            "prefix": 24

          },

          "enabled": true

        },

        "static": {

          "ip": [

            {

              "ip": "192.168.2.66",

              "prefix": 24

            }

          ],

          "gateway": "192.168.2.1",

          "dns": {

            "servers": [

              "",

              ""

            ]

          }

        }

      }

    }

  },

  "wireless": {

    "countrycode": "LT",

    "scenario": "ptmp",

    "radio": [

      {

        "amsdu": true,

        "fragmentation": {

          "size": 256,

          "enabled": false

        },

        "prohibited": false,

        "enabled": true,

        "channel": {

          "list": [

            2412

          ],

          "width": 20,

          "nonstandard": false,

          "select": "list",

          "extension": "upper"

        },

        "ieeemode": "bgn",

        "txpower": 20,

        "ifname": "wifi0",

        "vap": [

          {
            "wmm": true,

            "l2isolation": false,

            "hidden": false,

            "ssid2vlan": {

              "id":
EOF

if [ $vlan,_id -e 0]:  
	then
	echo $vlan_id >>temp
	echo ", \"enabled\": false" >>temp
	echo "nera vlan"
else
	echo $vlan_id >>temp
        echo ", \"enabled\": true" >>temp
	echo "yra vlan"
fi

cat >> temp<<EOF

            },

            "security": {

              "mode": "wpapsk",

              "wpaenterprise": {

                "authentication": {

                  "identity": "username",

                  "password": "password",

                  "eap": "ttls",

                  "servers": [

                    {

                      "secret": "",

                      "port": 1812,

                      "address": "0.0.0.0"

                    }

                  ]

                },

                "accounting": {

                  "servers": [

                    {

                      "secret": "",

                      "port": 1813,

                      "address": "0.0.0.0"

                    }

                  ],

                  "enabled": true

                }

              },

              "wpapsk": {

                "passphrase": "
EOF

echo  $psw>>temp
cat >> temp<<EOF
"
              },

              "wep": {

                "key": "",

                "length": 128,

                "index": 1

              }

            },

            "cwm": false,

            "maxclients": 128,

            "bssid": {

              "value": "00:00:00:00:00:00",

              "enabled": false

            },

            "minsignal": -90,

            "ifname": "ath0",

            "shortgi": true,

            "rate": {

              "legacy": "auto",

              "mcs": "auto"

            },

            "acl": {

              "fromurl": {

                "interval": 60,

                "autoupdate": false,

                "url": "http://"

              },

              "policy": "open",

              "source": "manually"

            },

            "mode": "ap",

            "wds": true,

            "ssid": "
EOF

echo $ssid>>temp

cat >> temp<<EOF
",

            "management": {

              "enabled": false,

              "tagged": false

            }

          },
        ],

        "rts": {

          "size": 256,

          "enabled": false

        },

        "bawinsize": 64,

        "acktimeout": 100,

        "atpc": false,

        "wjet": {

          "enabled": false

        },

        "dfs": false

      },

      {

        "amsdu": true,

        "fragmentation": {

          "size": 256,

          "enabled": false

        },

        "prohibited": false,

        "enabled": true,

        "channel": {

          "select": "all",

          "width": 40,

          "extension": "upper"

        },

        "ieeemode": "an",

        "txpower": 20,

        "ifname": "wifi1",

        "vap": [

          {

            "wmm": true,

            "l2isolation": false,

            "hidden": false,

            "ssid2vlan": {

              "id": 
EOF

if [$vlan_id -e '0']
        then
        echo $vlan_id >>temp
        echo ", \"enabled\": false" >>temp
        echo "nera vlan"
else
        echo $vlan_id >>temp
        echo ", \"enabled\": true" >>temp
        echo "yra vlan"
fi

cat >> temp<<EOF
            },

            "security": {

              "mode": "wpapsk",

              "wpaenterprise": {

                "authentication": {

                  "identity": "username",

                  "password": "password",

                  "eap": "ttls",

                  "servers": [

                    {

                      "secret": "",

                      "port": 1812,

                      "address": "0.0.0.0"

                    }

                  ]

                },

                "accounting": {

                  "servers": [

                    {

                      "secret": "",

                      "port": 1813,

                      "address": "0.0.0.0"

                    }

                  ],

                  "enabled": true

                }

              },

              "wpapsk": {

                "passphrase": "
EOF

echo $psw>>temp

cat >> temp<<EOF
"

              },

              "wep": {

                "key": "",

                "length": 128,

                "index": 1

              }

            },

            "cwm": false,

            "maxclients": 128,

            "bssid": {

              "value": "00:00:00:00:00:00",

              "enabled": false

            },

            "minsignal": -90,

            "ifname": "ath1",

            "shortgi": true,

            "rate": {

              "legacy": "auto",

              "mcs": "auto"

            },

            "acl": {

              "fromurl": {

                "interval": 60,

                "autoupdate": false,

                "url": "http://"

              },

              "policy": "open",

              "source": "manually"

            },

            "mode": "ap",

            "wds": true,

            "ssid": "
EOF

echo $ssid>>temp

cat >> temp<<EOF
",

            "management": {

              "enabled": true,

              "tagged": true

            }

          }

        ],

        "rts": {

          "size": 256,

          "enabled": false

        },

        "bawinsize": 64,

        "acktimeout": 100,

        "atpc": false,

        "wjet": {

          "enabled": false

        },

        "dfs": true

      }

    ]

  },

  "services": {

    "telnet": {

      "port": 23,

      "enabled": false

    },

    "dhcpd": {

      "leasetime": 86400,

      "pool": {

        "from": "192.168.2.101",

        "to": "192.168.2.200"

      },

      "prefix": 24,

      "gateway": "192.168.2.66",

      "enabled": true

    },

    "dhcp6d": {

      "leasetime": 86400,

      "pool": {

        "from": "2001::1000",

        "to": "2001::ffff"

      },

      "prefix": 64,

      "stateful": true,

      "enabled": false

    },

    "tc": {

      "master": {

        "profiles": [

          {

            "outgoing": {

              "burst": 59,

              "speed": 2048,

              "limited": true

            },

            "name": "Default",

            "incoming": {

              "burst": 50,

              "speed": 1024,

              "limited": false

            }

          }

        ],

        "enabled": false

      },

      "managed": {

        "profiles": [

          {

            "outgoing": {

              "burst": 59,

              "speed": 2048,

              "limited": true

            },

            "name": "Default",

            "incoming": {

              "burst": 50,

              "speed": 1000,

              "limited": false

            }

          }

        ],

        "enabled": false

      }

    },

    "ledd": {

      "enabled": true

    },

    "ntp": {

      "servers": [

        "pool.ntp.org"

      ],

      "enabled": false

    },

    "pingwatchdog": {

      "ip": "192.168.2.66",

      "interval": 1,

      "failcount": 2,

      "enabled": false

    },

    "wnms": {

      "host": "https://vilpalu.int.ktu.lt",

      "enabled": true

    },

    "snmp": {

      "ropassword": "password",

      "rocommunity": "public",

      "rouser": "public",

      "enabled": false

    },

    "ssh": {

      "port": 22,

      "enabled": true

    },

    "http": {

      "port": 80,

      "enabled": true

    },

    "discovery": {

      "enabled": false

    }

  },

  "system": {

    "log": {

      "level": "debug"

    },

    "device": {

      "coordinate": {

        "longitude": 0,

        "latitude": 0

      },

      "location": "Device location",

      "contact": "Contact",

      "name": "testuojamas",

      "firmwareid": "AP.QD-1"

    },

    "publicstatus": {

      "enabled": true

    },

    "poe": {

      "enabled": false

    },

    "date": {

      "date": "01/07/2014",

      "time": "00:00",

      "timezone": "UTC"

    },

    "users": [

      {

        "password": "oHSl3yqR.t1uQ",

        "name": "admin",

        "home": "/data",

        "agreement": true

      },

      {

        "shell": "/bin/false",

        "home": "/var/run/openntpd",

        "gid": 65534,

        "name": "_ntp",

        "password": "*",

        "uid": 1

      }

    ]

  }

}
EOF
