using Toybox.Sensor;
using Toybox.Timer;
using Toybox.Application.Properties;
using Toybox.Lang;
using Toybox.System;

class DataManager {
    private var hrZones;
    private var minStrideLength;
    private var targetSpeed;
    private var timer;
    private var audioManager;
    private var uiCallback;
    private var currentZone;
    private var lastFeedbackTime;
    private var lastHRFeedbackTime;
    private var lastCadenceFeedbackTime;

    // Constants
    private const FEEDBACK_COOLDOWN = 30; // seconds between general feedback
    private const HR_FEEDBACK_COOLDOWN = 60; // seconds between HR feedback
    private const CADENCE_FEEDBACK_COOLDOWN = 45; // seconds between cadence feedback

    function initialize(audioMgr) {
        // Set default values
        hrZones = [120, 140, 160, 180];
        minStrideLength = 0.7f;
        targetSpeed = 3.0f;
        
        timer = new Timer.Timer();
        audioManager = audioMgr;
        currentZone = 0;
        lastFeedbackTime = 0;
        lastHRFeedbackTime = 0;
        lastCadenceFeedbackTime = 0;
    }

    function loadSettings() {
        // Load HR zones from settings or keep defaults
        var z1 = Properties.getValue("zone1");
        var z2 = Properties.getValue("zone2");
        var z3 = Properties.getValue("zone3");
        var z4 = Properties.getValue("zone4");
        
        if (z1 != null && z2 != null && z3 != null && z4 != null) {
            hrZones = [z1, z2, z3, z4];
        }

        // Load pace settings
        var tgtSpeed = Properties.getValue("targetSpeed");
        if (tgtSpeed != null) {
            targetSpeed = tgtSpeed.toFloat();
        }

        var minStride = Properties.getValue("minStride");
        if (minStride != null) {
            minStrideLength = minStride.toFloat();
        }
    }

    function setCallback(callback) {
        uiCallback = callback;
    }

    function start() {
        // Enable the sensor
        var options = {
            :period => 1,              // 1 second between readings
            :sampleRate => 1,          // 1 Hz sampling rate
            :enableAccelerometer => true,
            :enableHeartRate => true
        };

        Sensor.registerSensorDataListener(method(:onSensorData), options);
        
        // Start timer for activity info updates
        timer = new Timer.Timer();
        timer.start(method(:onTimer), 1000, true);
    }

    function stop() {
        Sensor.unregisterSensorDataListener();
        if (timer != null) {
            timer.stop();
        }
    }

    function onSensorData(data as Sensor.SensorData) as Void {
        var hr = "--";
        var cadence = "--";
        var currentTime = System.getTimer() / 1000; // Convert to seconds

        if (data has :heartRate && data.heartRate != null) {
            hr = data.heartRate;
            if (currentTime - lastHRFeedbackTime >= HR_FEEDBACK_COOLDOWN) {
                checkHeartRate(hr, currentTime);
            }
        }
        if (data has :cadence && data.cadence != null) {
            cadence = data.cadence;
            if (currentTime - lastCadenceFeedbackTime >= CADENCE_FEEDBACK_COOLDOWN) {
                checkCadence(cadence, currentTime);
            }
        }

        // Update UI
        if (uiCallback != null) {
            uiCallback.invoke(hr, currentZone, cadence);
        }
    }

    function onTimer() as Void {
        if (Activity has :getActivityInfo) {
            var info = Activity.getActivityInfo();
            if (info != null) {
                var hr = info.currentHeartRate;
                var cad = info.currentCadence;
                
                if (hr != null || cad != null) {
                    processActivityData(hr, cad);
                }
            }
        }
    }

    function processActivityData(hr, cadence) {
        var currentTime = System.getTimer() / 1000;
        
        if (hr != null) {
            if (currentTime - lastHRFeedbackTime >= HR_FEEDBACK_COOLDOWN) {
                checkHeartRate(hr, currentTime);
            }
        }
        
        if (cadence != null) {
            if (currentTime - lastCadenceFeedbackTime >= CADENCE_FEEDBACK_COOLDOWN) {
                checkCadence(cadence, currentTime);
            }
        }

        // Update UI
        if (uiCallback != null) {
            uiCallback.invoke(hr != null ? hr : "--", currentZone, cadence != null ? cadence : "--");
        }
    }

    private function checkHeartRate(hr, currentTime) {
        // Update zone
        var oldZone = currentZone;
        currentZone = 0;
        for (var i = 0; i < hrZones.size(); i++) {
            if (hr < hrZones[i]) {
                currentZone = i;
                break;
            }
            currentZone = i + 1;
        }

        // Only provide feedback if zone changed or enough time passed
        if (currentTime - lastHRFeedbackTime >= HR_FEEDBACK_COOLDOWN) {
            if (currentZone == 0) {
                audioManager.playPrompt("push_harder");
                lastHRFeedbackTime = currentTime;
            } else if (currentZone >= 4) {
                audioManager.playPrompt("slow_down");
                lastHRFeedbackTime = currentTime;
            } else if (oldZone != currentZone) {
                // Zone change notification
                if (currentZone > oldZone) {
                    audioManager.playPrompt("zone_up");
                } else {
                    audioManager.playPrompt("zone_down");
                }
                lastHRFeedbackTime = currentTime;
            }
        }
    }

    private function checkCadence(cadence, currentTime) {
        // Only check if enough time has passed since last feedback
        if (currentTime - lastCadenceFeedbackTime >= CADENCE_FEEDBACK_COOLDOWN) {
            if (cadence != null && cadence > 0) {
                var strideLength = targetSpeed / cadence;
                if (strideLength < minStrideLength) {
                    audioManager.playPrompt("lengthen_stride");
                    lastCadenceFeedbackTime = currentTime;
                } else {
                    // Calculate pace
                    var currentSpeed = (strideLength * cadence);
                    var speedDiff = (currentSpeed - targetSpeed).abs();
                    
                    if (speedDiff <= 0.2) { // Within 0.2 m/s of target
                        audioManager.playPrompt("great_pace");
                    } else if (currentSpeed < targetSpeed) {
                        audioManager.playPrompt("speed_up");
                    } else {
                        audioManager.playPrompt("slow_down");
                    }
                    lastCadenceFeedbackTime = currentTime;
                }
            }
        }
    }
} 