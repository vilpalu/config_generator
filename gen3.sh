#!/bin/bash
#generatorius konfiguracijos

begin() {
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
EOF
}

add_vap() {

cat >>temp<<EOF
 "wmm": true,
            "l2isolation": false,
            "hidden": false,
            "ssid2vlan": {
              "id":
EOF
echo "\"id\":" $vlan_id","  >>temp
if [ "$vlan_id" = "0" ]
        then
        echo "\"enabled\": false" >>temp
        echo "nera vlan"
else
	echo "\"enabled\": true" >>temp
        echo "yra vlan"
fi

at >> temp<<EOF
            },
            "wds": true,
EOF

echo  "\"ssid\": \""$ssid"\",">>temp
cat >> temp<<EOF
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
echo  "\"passphrase\": "\"$psw"\"">>temp
cat >> temp<<EOF
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
          }
EOF
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
#-----------------------------main
rm temp
echo "irasykite tinklo pavadinima"
read ssid

echo "irasykite vlan, jei ne rasykite "

read vlan_id

echo "irasykite tinklo slaptazodi"

read psw
begin
add_vap
ghz
add_vap
pabaiga






