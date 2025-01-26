# PulseCoach Development Knowledge Base

## Project Structure
- Main app class (`PulseCoachApp`) extends `Application.AppBase`
- View class (`PulseCoachView`) extends `WatchUi.View`
- Separate managers for data (`DataManager`) and audio (`AudioManager`)
- Settings stored in `resources/settings/settings.xml`

## Key Learnings

### App Architecture
1. App initialization flow:
   - `AppBase.initialize()`
   - Create managers (AudioManager, DataManager)
   - Set up view with data manager reference
   - View handles UI updates via callback

### Sensor Data
1. Sensor registration requires:
   ```monkey
   var options = {
       :period => 1,              // 1 second between readings
       :sampleRate => 1,          // 1 Hz sampling rate
       :enableAccelerometer => true,
       :enableHeartRate => true
   };
   Sensor.registerSensorDataListener(method(:onSensorData), options);
   ```

### Settings
1. Settings must be defined in XML with specific format:
   ```xml
   <setting propertyKey="@Properties.key">
       <settingConfig type="numeric">
           <listEntry value="value"/>
       </settingConfig>
   </setting>
   ```
2. Access settings via `Properties.getValue("key")`

### UI Development
1. View updates must be requested explicitly via `WatchUi.requestUpdate()`
2. Graphics context provides basic drawing functions:
   - `dc.clear()`
   - `dc.setColor()`
   - `dc.drawText()`
   - `dc.fillCircle()`

### Audio/Haptic Feedback
1. Use `Attention` module for feedback:
   - `Attention.playTone()` for audio
   - `Attention.vibrate()` with `VibeProfile` for haptic
2. Different tone types available:
   - `TONE_LOUD_BEEP`
   - `TONE_SUCCESS`
   - `TONE_ALERT_HI`
   - `TONE_ALERT_LO`

### Simulator
1. Working simulator configuration:
   ```bash
   # Start simulator (shows watch with grey background)
   cd "$HOME/.Garmin/ConnectIQ/Sdks/connectiq-sdk-lin-7.4.3-2024-12-11-90ec25e45/bin" && \
   DISPLAY=:0 QT_QPA_PLATFORM=xcb ./simulator \
     --configPath="$HOME/.Garmin/ConnectIQ/Devices/fr245m/simulator.json" \
     --devicePath="$HOME/.Garmin/ConnectIQ/Devices/fr245m" \
     --debug

   # Load app into simulator (shows PulseCoach app)
   cd /path/to/PulseCoach && \
   "$HOME/.Garmin/ConnectIQ/Sdks/connectiq-sdk-lin-7.4.3-2024-12-11-90ec25e45/bin/monkeydo" \
   "$(pwd)/bin/PulseCoach.prg" fr245m
   ```
2. Minimal environment variables needed:
   - DISPLAY=:0
   - QT_QPA_PLATFORM=xcb
3. Simulator features:
   - Press Ctrl + K to open sensor panel
   - Heart Rate tab for simulating heart rate
   - Running tab for simulating cadence

## Common Issues & Solutions
1. Type casting in Monkey C requires explicit Lang namespace:
   - Use `Lang.Number` instead of `Number`
   - Use `Lang.Float` instead of `Float`

2. Settings must use `listEntry` for numeric values instead of min/max ranges

3. Container access warnings can be ignored if data structure is correct

## TODO/Investigation Needed
1. Documentation on available sensor data types and formats 