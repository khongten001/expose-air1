/*
 *   Copyright 2014 Marco Martin <mart@kde.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License version 2,
 *   or (at your option) any later version, as published by the Free
 *   Software Foundation
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtQuick 2.5
import QtQuick.Window 2.2
import org.kde.plasma.core 2.0 as PlasmaCore
import QtGraphicalEffects 1.0

Image {
    id: root
//     color: "#393939"
    source: "images/airlogin3.png"
    property int stage

    onStageChanged: {
        if (stage == 1) {
            introAnimation.running = true;
        } else if (stage == 6) {
            introAnimation.target = busyIndicator;
            introAnimation.from = 1;
            introAnimation.to = 0;
            introAnimation.running = true;
        } else if (stage == 5) {
            introAnimation.target = busyShadow;
            introAnimation.from = 1;
            introAnimation.to = 0;
            introAnimation.running = true;
        }
    }

    Item {
        id: content
        anchors.fill: parent
        opacity: 0

        Image {
            id: busyIndicator
            x: parent.width / 2 - 48
            y: parent.height / 1.5 - 48
            z: 3
            source: "images/gear.svg"
            width: 96
            height: 96
            RotationAnimator on rotation {
                id: rotationAnimator
                from: 0
                to: 360
                duration: 2600
                loops: Animation.Infinite
            }
        }
        Image {
            id: busyShadow
            z: 2
            x: parent.width / 2 - 44
            y: parent.height / 1.5 - 44
            source: "images/gear2.svg"
            width: 96
            height: 96
            RotationAnimator on rotation {
                id: rotationAnimator2
                from: 0
                to: 360
                duration: 2600
                loops: Animation.Infinite
            }
        }
    }

    OpacityAnimator {
        id: introAnimation
        running: false
        target: content
        from: 0
        to: 1
        duration: 2000
        easing.type: Easing.InOutQuad
    }
}