//
// Copyright 2023 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;

//! This class demonstrate how to use TTF with face name(s) and size
class TrueTypeFontsVectorFontsView extends TrueTypeFontsView {

    typedef Options as {
        :name as String,
        :face as String or Array<String>,
        :size as Number
    };

    private var _vectorFontOption as Array<Options>;
    private var _availableFaceNames as Array<String>;
    private var _fontScale as Float;

    //! Constructor
    function initialize() {
        _availableFaceNames = getAllAvailableTrueTypeFontFaceNames();
        _fontScale = System.getDeviceSettings().fontScale;

        _vectorFontOption = [];
        _vectorFontOption.add({
            :name => "Font Name",
            :face => _availableFaceNames[0],
            :size => 50,
        });
        _vectorFontOption.add({
            :name => "Font Size 0",
            :face => _availableFaceNames[0],
            :size =>  0,
        });
        _vectorFontOption.add({
            :name => "Font Size Missing",
            :face => _availableFaceNames[0],
        });
        _vectorFontOption.add({
            :name => "Font Name Invalid",
            :face => "InvalidFont",
            :size => 50,
        });
        _vectorFontOption.add({
            :name => "Invalid Font Size",
            :face => _availableFaceNames[0],
            :size =>  -1,
        });
        _vectorFontOption.add({
            :name => "Font Names Array",
            :face => [
                _availableFaceNames[0],
                _availableFaceNames[1],
            ],
            :size => 20,
        });

        TrueTypeFontsView.initialize(_vectorFontOption.size());
    }

    //! Update the view
    //! @param dc Device context
    function onUpdate(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();

        var options = _vectorFontOption[_viewId];

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth() / 2, 50, Graphics.FONT_XTINY, options[:name] as String, Graphics.TEXT_JUSTIFY_CENTER);

        var fontSize = options[:size] as Number * _fontScale;

        // Draw the vector font name given the _vectorFontOption array as parameters.
        try {
            var font = Graphics.getVectorFont({
                :face => options[:face] as String,
                :size => fontSize
            });

            if (font != null) {
                var text = Lang.format("$1$ $2$", [
                    options[:face] as String,
                    fontSize
                ]);

                dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, font, text, Graphics.TEXT_JUSTIFY_CENTER);
            } else {
                dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, Graphics.FONT_XTINY, "No Font", Graphics.TEXT_JUSTIFY_CENTER);
            }

        } catch (e) {

            var msg = e.getErrorMessage();

            if (msg == null) {
                msg = e.toString();
            }

            dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, Graphics.FONT_XTINY, msg, Graphics.TEXT_JUSTIFY_CENTER);
        }
    }
}