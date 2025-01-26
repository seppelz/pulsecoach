//
// Copyright 2023 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.Math;

using Toybox.System;

//! This class shows the face name of the available TTF fonts
class TrueTypeFontsFontMappingView extends TrueTypeFontsView {

    private var _fontsArray as Array<String>;
    private var _maxLinesPerScreen as Number;
    private var _fontScale as Float;

    //! Constructor
    function initialize() {
        TrueTypeFontsView.initialize(0);
        _fontsArray = getAllAvailableTrueTypeFontFaceNames();
        _maxLinesPerScreen = 2;
        _fontScale = System.getDeviceSettings().fontScale;
    }

    //! Load your resources here
    //! @param dc Device context
    function onLayout(dc) {
        _maxLinesPerScreen = (dc.getHeight() / 2) / dc.getFontHeight(Graphics.FONT_XTINY);
        var numPages = Math.ceil(1.0f * _fontsArray.size() / _maxLinesPerScreen);
        _viewIdMax = numPages.toNumber();
    }

    //! Update the view
    //! @param dc Device context
    function onUpdate(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        var font = Graphics.FONT_XTINY;
        var dy = dc.getFontHeight(font);
        var cx = dc.getWidth() / 2;
        var cy = dc.getHeight() / 2;

        var just = Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER;

        cy -= (_maxLinesPerScreen * dy) / 2;

        for (var i = _viewId * _maxLinesPerScreen; i < (_viewId + 1) * _maxLinesPerScreen && i < _fontsArray.size(); ++i) {
            var vectorFont = Graphics.getVectorFont({:face =>_fontsArray[i] , :size => 16 * _fontScale});
            font = (vectorFont != null) ? vectorFont : Graphics.FONT_XTINY;
            dc.drawText(cx, cy, font, _fontsArray[i], just);
            cy += dy;
        }

        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(cx, dc.getHeight() / 8, Graphics.FONT_XTINY, (_viewId + 1) + " / " + _viewIdMax, Graphics.TEXT_JUSTIFY_CENTER);
    }
}