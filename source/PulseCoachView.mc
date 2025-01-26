using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.Sensor;

class PulseCoachView extends WatchUi.View {
    private var dataManager;
    private var currentHR = "--";
    private var currentZone = 0;
    private var currentCadence = "--";

    function initialize(dataMgr) {
        View.initialize();
        dataManager = dataMgr;
        dataManager.setCallback(method(:onDataUpdate));
    }

    // Called when the view is shown
    function onShow() {
        dataManager.start();
    }

    // Called when the view is hidden
    function onHide() {
        dataManager.stop();
    }

    // Callback for data updates
    function onDataUpdate(hr, zone, cadence) {
        currentHR = hr;
        currentZone = zone;
        currentCadence = cadence;
        WatchUi.requestUpdate();
    }

    // Update the view
    function onUpdate(dc) {
        // Clear the screen
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();

        // Set text color
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);

        // Draw app name at the top
        dc.drawText(
            dc.getWidth() / 2,
            10,
            Graphics.FONT_SMALL,
            "PulseCoach",
            Graphics.TEXT_JUSTIFY_CENTER
        );

        // Draw heart rate with zone color
        var zoneColors = [
            Graphics.COLOR_RED,      // Below Zone 1
            Graphics.COLOR_GREEN,    // Zone 1
            Graphics.COLOR_YELLOW,   // Zone 2
            Graphics.COLOR_ORANGE,   // Zone 3
            Graphics.COLOR_RED       // Zone 4
        ];
        dc.setColor(zoneColors[currentZone], Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            dc.getWidth() / 2,
            dc.getHeight() / 2 - 40,
            Graphics.FONT_LARGE,
            currentHR.toString() + " bpm",
            Graphics.TEXT_JUSTIFY_CENTER
        );

        // Draw zone indicator
        dc.drawText(
            dc.getWidth() / 2,
            dc.getHeight() / 2,
            Graphics.FONT_MEDIUM,
            "Zone " + currentZone,
            Graphics.TEXT_JUSTIFY_CENTER
        );

        // Draw cadence
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            dc.getWidth() / 2,
            dc.getHeight() / 2 + 40,
            Graphics.FONT_MEDIUM,
            currentCadence.toString() + " spm",
            Graphics.TEXT_JUSTIFY_CENTER
        );

        // Draw circular zone indicator
        var centerX = dc.getWidth() / 2;
        var centerY = dc.getHeight() - 30;
        var radius = 15;
        
        // Background circle
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.fillCircle(centerX, centerY, radius);
        
        // Zone progress
        if (currentZone > 0) {
            dc.setColor(zoneColors[currentZone], Graphics.COLOR_TRANSPARENT);
            dc.fillCircle(centerX, centerY, (radius * currentZone) / 4);
        }
    }
} 