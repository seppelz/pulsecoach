using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.Sensor;

class PulseCoachTestView extends WatchUi.View {
    private var hrIterator;

    function initialize() {
        View.initialize();
        hrIterator = new SensorIterator();
    }

    function onLayout(dc) {
        // Layout setup
    }

    function onUpdate(dc) {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.clear();
        
        // Draw Hello World
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            dc.getWidth()/2, 
            dc.getHeight()/2 - 30, 
            Graphics.FONT_MEDIUM,
            "PulseCoach Test",
            Graphics.TEXT_JUSTIFY_CENTER
        );
        
        // Get and display heart rate
        var info = hrIterator.getHeartRate();
        var hrText = "HR: " + (info != null ? info.toString() : "--") + " bpm";
        dc.drawText(
            dc.getWidth()/2,
            dc.getHeight()/2 + 10,
            Graphics.FONT_MEDIUM,
            hrText,
            Graphics.TEXT_JUSTIFY_CENTER
        );
    }
}

class SensorIterator {
    function getHeartRate() {
        var info = Sensor.getInfo();
        return info != null ? info.heartRate : null;
    }
} 