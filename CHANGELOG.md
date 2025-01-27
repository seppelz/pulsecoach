# Changelog

## [Unreleased]

### Added
- Configurable heart rate zones and target speed settings
- Audio prompts for zone changes and pace feedback
- Improved audio feedback system with customized tones and vibrations
- Working simulator configuration with proper display and sensor panel access
- Initial GitHub repository setup at https://github.com/seppelz/pulsecoach

### Fixed
- Simulator display and window management issues
- Audio manager initialization and feedback timing
- Data manager settings handling and defaults

### Changed
- Simplified simulator startup script for better reliability
- Improved error handling in settings loading

## [1.0.0] - 2024-03-20

### Added
- Configurable heart rate zones and target speed settings
- Audio prompts for zone changes and pace feedback
- Improved audio feedback system with customized tones and vibrations
- Dual sensor data handling (direct sensor and activity data)
- Visual feedback with zone-specific colors and progress indicator
- Initial GitHub repository setup at https://github.com/seppelz/pulsecoach

### Fixed
- Simulator sensor data handling by implementing both direct and activity data sources
- Audio manager initialization and feedback timing
- Data manager settings handling and defaults
- Type safety in callback functions

### Changed
- Enhanced sensor data processing with robust null checks
- Improved error handling in settings loading
- Optimized UI updates for real-time data display

### Technical Details
- Added required permissions: Sensor, FitContributor, UserProfile
- Implemented dual-source sensor data handling
- Enhanced data processing pipeline for consistent UI updates 