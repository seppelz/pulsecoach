using Toybox.Attention;

class AudioManager {
    private var prompts;

    function initialize() {
        prompts = {
            "push_harder" => "Push harder! You've got this!",
            "great_pace" => "Great pace! Keep it up!",
            "lengthen_stride" => "Lengthen your stride!",
            "slow_down" => "Slow down! Heart rate too high!",
            "speed_up" => "Speed up! You can do it!",
            "zone_up" => "Moving up a zone!",
            "zone_down" => "Moving down a zone!"
        };
    }

    function playPrompt(promptKey) {
        if (prompts.hasKey(promptKey)) {
            // Use vibration and tone for feedback
            if (Attention has :playTone) {
                var toneProfile = {
                    "push_harder" => Attention.TONE_LOUD_BEEP,
                    "great_pace" => Attention.TONE_SUCCESS,
                    "lengthen_stride" => Attention.TONE_ALERT_HI,
                    "slow_down" => Attention.TONE_ALERT_LO,
                    "speed_up" => Attention.TONE_INTERVAL_ALERT,
                    "zone_up" => Attention.TONE_SUCCESS,
                    "zone_down" => Attention.TONE_ALERT_LO
                };
                
                if (toneProfile.hasKey(promptKey)) {
                    Attention.playTone(toneProfile[promptKey]);
                }
            }
            
            if (Attention has :vibrate) {
                var vibeProfiles = {
                    "push_harder" => [new Attention.VibeProfile(50, 500)],
                    "great_pace" => [new Attention.VibeProfile(100, 100)],
                    "lengthen_stride" => [new Attention.VibeProfile(75, 300)],
                    "slow_down" => [new Attention.VibeProfile(100, 300)],
                    "speed_up" => [new Attention.VibeProfile(50, 100)],
                    "zone_up" => [new Attention.VibeProfile(100, 100)],
                    "zone_down" => [new Attention.VibeProfile(75, 300)]
                };
                
                if (vibeProfiles.hasKey(promptKey)) {
                    Attention.vibrate(vibeProfiles[promptKey]);
                }
            }
        }
    }
} 