var plasma = getApiVersion(1);

var layout = {
    "desktops": [
        {
            "applets": [
                {
                    "config": {
                        "/": {
                            "PreloadWeight": "0"
                        },
                        "/ConfigDialog": {
                            "DialogHeight": "510",
                            "DialogWidth": "680"
                        },
                        "/General": {
                            "showSecondHand": "true"
                        }
                    },
                    "geometry.height": 0,
                    "geometry.width": 0,
                    "geometry.x": 0,
                    "geometry.y": 0,
                    "plugin": "org.kde.plasma.analogclock",
                    "title": "Analog Clock"
                }
            ],
            "config": {
                "/": {
                    "ItemGeometries-1920x1080": "Applet-149:1696,16,208,192,0;Applet-155:1168,224,752,576,0;Applet-157:1440,832,464,160,0;",
                    "ItemGeometries-2560x1331": "",
                    "ItemGeometries-2560x1440": "Applet-149:2320,48,192,192,0;",
                    "ItemGeometriesHorizontal": "Applet-149:2320,48,192,192,0;",
                    "formfactor": "0",
                    "immutability": "1",
                    "lastScreen": "0",
                    "wallpaperplugin": "org.kde.image"
                },
                "/ConfigDialog": {
                    "DialogHeight": "570",
                    "DialogWidth": "760"
                },
                "/Configuration": {
                    "PreloadWeight": "0"
                },
                "/General": {
                    "ToolBoxButtonState": "topcenter",
                    "ToolBoxButtonX": "927",
                    "positions": "{\"1920x1080\":[]\\,\"2560x1440\":[]}",
                    "sortMode": "-1"
                },
                "/Wallpaper/org.kde.color/General": {
                    "Color": "85,170,255"
                },
                "/Wallpaper/org.kde.image/General": {
                    "Image": "/home/mark/.local/share/wallpapers/ExposeAir/",
                    "SlidePaths": "/usr/share/wallpapers"
                }
            },
            "wallpaperPlugin": "org.kde.image"
        }
    ],
    "panels": [
        {
            "alignment": "center",
            "applets": [
                {
                    "config": {
                        "/": {
                            "PreloadWeight": "85"
                        },
                        "/General": {
                            "favoritesPortedToKAstats": "true"
                        }
                    },
                    "plugin": "org.kde.plasma.kickoff"
                },
                {
                    "config": {
                        "/": {
                            "PreloadWeight": "0"
                        }
                    },
                    "plugin": "org.kde.plasma.marginsseparator"
                },
                {
                    "config": {
                        "/": {
                            "PreloadWeight": "0",
                            "localPath": "/home/mark/.local/share/plasma_icons/microsoft-edge.desktop",
                            "url": "file:///usr/share/applications/microsoft-edge.desktop"
                        }
                    },
                    "plugin": "org.kde.plasma.icon"
                },
                {
                    "config": {
                        "/": {
                            "PreloadWeight": "0",
                            "localPath": "/home/mark/.local/share/plasma_icons/org.kde.dolphin.desktop",
                            "url": "file:///usr/share/applications/org.kde.dolphin.desktop"
                        }
                    },
                    "plugin": "org.kde.plasma.icon"
                },
                {
                    "config": {
                        "/": {
                            "PreloadWeight": "0",
                            "localPath": "/home/mark/.local/share/plasma_icons/org.kde.konsole.desktop",
                            "url": "file:///usr/share/applications/org.kde.konsole.desktop"
                        }
                    },
                    "plugin": "org.kde.plasma.icon"
                },
                {
                    "config": {
                        "/": {
                            "PreloadWeight": "0"
                        },
                        "/General": {
                            "launchers": ""
                        }
                    },
                    "plugin": "org.kde.plasma.icontasks"
                },
                {
                    "config": {
                        "/": {
                            "PreloadWeight": "0"
                        }
                    },
                    "plugin": "org.kde.plasma.pager"
                },
                {
                    "config": {
                        "/": {
                            "PreloadWeight": "0"
                        }
                    },
                    "plugin": "org.kde.plasma.systemtray"
                },
                {
                    "config": {
                        "/": {
                            "PreloadWeight": "0"
                        },
                        "/Appearance": {
                            "fontFamily": "Selawik",
                            "showDate": "false"
                        },
                        "/ConfigDialog": {
                            "DialogHeight": "570",
                            "DialogWidth": "760"
                        }
                    },
                    "plugin": "org.kde.plasma.digitalclock"
                },
                {
                    "config": {
                        "/": {
                            "PreloadWeight": "34"
                        }
                    },
                    "plugin": "org.kde.plasma.lock_logout"
                }
            ],
            "config": {
                "/": {
                    "formfactor": "2",
                    "immutability": "1",
                    "lastScreen": "0",
                    "wallpaperplugin": "org.kde.image"
                },
                "/ConfigDialog": {
                    "DialogHeight": "84",
                    "DialogWidth": "2560"
                },
                "/Configuration": {
                    "PreloadWeight": "0"
                }
            },
            "height": 2.6666666666666665,
            "hiding": "normal",
            "location": "bottom",
            "maximumLength": 142.22222222222223,
            "minimumLength": 142.22222222222223,
            "offset": 0
        }
    ],
    "serializationFormatVersion": "1"
}
;

plasma.loadSerializedLayout(layout);
