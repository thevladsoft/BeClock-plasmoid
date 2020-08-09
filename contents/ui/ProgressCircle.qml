 
// ByteBau (Jörn Buchholz) @bytebau.com

import QtQuick 2.0
import QtQml 2.2

Item {
    id: root

    width: size
    height: size

    property int size: 200               // The size of the circle in pixel
    property real arcBegin: 0            // start arc angle in degree
    property real arcEnd: 270            // end arc angle in degree
    property real arcOffset: 0           // rotation
    property bool isPie: false           // paint a pie instead of an arc
    property bool showBackground: false  // a full circle as a background of the arc
    property real lineWidth: 20          // width of the line
    property string colorCircle: "#CC3333"
    property string colorBackground: "#779933"
	
	property bool colorGrad: false

    property alias beginAnimation: animationArcBegin.enabled
    property alias endAnimation: animationArcEnd.enabled

    property int animationDuration: 400

    onArcBeginChanged: canvas.requestPaint()
    onArcEndChanged: canvas.requestPaint()
    onColorCircleChanged: canvas.requestPaint()
    onColorBackgroundChanged: canvas.requestPaint()
	
	onSizeChanged: canvas.requestPaint()
	onLineWidthChanged: canvas.requestPaint()
	
	onColorGradChanged: canvas.requestPaint()

    Behavior on arcBegin {
       id: animationArcBegin
       enabled: true
       NumberAnimation {
           duration: root.animationDuration
           easing.type: Easing.InOutCubic
           from: root.arcBegin >=360 ? 0 : root.arcBegin
       }
    }

    Behavior on arcEnd {
       id: animationArcEnd
       enabled: true
       NumberAnimation {
           duration: root.animationDuration
           easing.type: Easing.InOutCubic
           from: root.arcEnd >=360 ? 0 : root.arcEnd
       }
    }
    

    Canvas {
        id: canvas
        anchors.fill: parent
        rotation: -90 + parent.arcOffset

        onPaint: {
            var ctx = getContext("2d")
            var x = width / 2
            var y = height / 2
            var start = Math.PI * (parent.arcBegin / 180)
            var end = Math.PI * (parent.arcEnd / 180)
            ctx.reset()
			
			if(root.colorGrad){
				var gradient = ctx.createConicalGradient(x, y, 0.);//createLinearGradient(0, 0, 100, 0);
				gradient.addColorStop((1.-parent.arcEnd/360.), root.colorCircle);
				gradient.addColorStop(1, Qt.lighter(root.colorCircle,1.7));//Qt.rgba(255, 255, 255, 0.1));
			}

            if (root.isPie) {
                if (root.showBackground) {
                    ctx.beginPath()
                    ctx.fillStyle = root.colorBackground
                    ctx.moveTo(x, y)
                    ctx.arc(x, y, width / 2, 0, Math.PI * 2, false)
                    ctx.lineTo(x, y)
                    ctx.fill()
                }
                ctx.beginPath()
                ctx.fillStyle = root.colorCircle
                ctx.moveTo(x, y)
                ctx.arc(x, y, width / 2, start, end, false)
                ctx.lineTo(x, y)
                ctx.fill()
            } else {
                if (root.showBackground) {
                    ctx.beginPath();
                    ctx.arc(x, y, (width / 2) - parent.lineWidth / 2, 0, Math.PI * 2, false)
                    ctx.lineWidth = root.lineWidth
                    ctx.strokeStyle = root.colorBackground
                    ctx.stroke()
                }
                ctx.beginPath();
                ctx.arc(x, y, (width / 2) - parent.lineWidth / 2, start, end, false)
                ctx.lineWidth = root.lineWidth
                ctx.strokeStyle = root.colorGrad ? gradient : root.colorCircle
                ctx.stroke()
            }
        }
    }
}
