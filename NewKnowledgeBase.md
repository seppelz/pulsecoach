# PulseCoach Knowledge Base

## Project Structure
- Main app components: PulseCoachApp, PulseCoachView, DataManager, AudioManager
- Settings configuration in resources/settings/settings.xml
- Audio and vibration feedback system for user notifications

## Key Learnings

### Simulator Setup
- Required permissions in manifest.xml:
  - `Sensor` for heart rate and cadence
  - `FitContributor` for activity data
  - `UserProfile` for user settings
- Simulator data can be accessed through:
  1. Direct sensor data via `Sensor.registerSensorDataListener`
  2. Activity data via `Activity.getActivityInfo`
- Best practice: Implement both methods for robust data handling

### Sensor Data Handling
- Use both sensor listener and activity info:
  ```monkey
  // Direct sensor data
  Sensor.registerSensorDataListener(callback, options);
  
  // Activity data polling
  timer.start(method(:onTimer), 1000, true);
  ```
- Process data through a common path for consistent UI updates
- Handle null values gracefully for both sources

### App Architecture
- DataManager handles sensor data collection and processing
- AudioManager provides feedback through tones and vibrations
- PulseCoachView manages UI updates and user interaction
- Settings provide configuration for zones and thresholds

### UI Development
- Watch face shows:
  - Heart rate with zone-specific colors
  - Current zone indicator
  - Cadence in steps per minute
  - Visual zone progress indicator

### Audio/Haptic Feedback
- Different tone profiles for various notifications
- Vibration patterns can convey different messages
- Cooldown periods prevent feedback overload

### Common Issues & Solutions
- Simulator sensor data: Implement both direct sensor and activity info handlers
- Type safety: Use proper type annotations for callbacks
- Settings loading: Include default values
- Sensor data: Validate and handle missing data

### TODO
- Implement more sophisticated pace calculations
- Add user customization for feedback preferences
- Enhance zone transition logic
- Add data logging capabilities

## TODO/Investigation Needed
1. Documentation on available sensor data types and formats 