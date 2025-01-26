//
// Copyright 2023 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;

//! The base class which remembers how many pages the view has
//! and update the view id for the page to be shown in the given direction
class TrueTypeFontsView extends WatchUi.View {

    hidden var _viewId as Number;
    hidden var _viewIdMax as Number;

    //! Constructor
    //! @param maxViewId The maximum view Id
    function initialize(maxViewId as Number) {
        View.initialize();

        _viewId = 0;
        _viewIdMax = maxViewId;
    }

    //! Change the pages in the given direction
    //! @param direction The direction
    public function changePage(direction as Direction) as Void {
        if (direction == DIRECTION_NEXT) {
           _viewId = (_viewId + 1) % _viewIdMax;
        } else {
            _viewId = (_viewId + (_viewIdMax - 1)) % _viewIdMax;
        }
    }
}