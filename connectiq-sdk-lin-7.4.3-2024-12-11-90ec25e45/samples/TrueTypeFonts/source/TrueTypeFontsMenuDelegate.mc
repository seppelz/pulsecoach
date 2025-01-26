//
// Copyright 2023 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Graphics;

//! Input handler to respond to menu selections
class TrueTypeFontsMenuDelegate extends WatchUi.Menu2InputDelegate {

   function initialize() {
      Menu2InputDelegate.initialize();
    }

   //! Push the map view corresponding to the selected menu item
   //! @param item Symbol identifier of the menu item that was chosen
   function onSelect(item) {
      if (item.getId() == :font_mapping ) {
         var view = new TrueTypeFontsFontMappingView();
         WatchUi.pushView(view, new TrueTypeFontsDelegate(view),  WatchUi.SLIDE_IMMEDIATE);
      }
      else if (item.getId() == :vector_fonts) {
         var view = new TrueTypeFontsVectorFontsView();
         WatchUi.pushView(view, new TrueTypeFontsDelegate(view),  WatchUi.SLIDE_IMMEDIATE);
      }
      else if (item.getId() == :angled_text) {
         var view = new TrueTypeFontsAngledTextView();
         WatchUi.pushView(view, new TrueTypeFontsDelegate(view),  WatchUi.SLIDE_IMMEDIATE);
      }
      else if (item.getId() == :radial_text) {
         var view = new TrueTypeFontsRadialTextView();
         WatchUi.pushView(view, new TrueTypeFontsDelegate(view),  WatchUi.SLIDE_IMMEDIATE);
      }
   }

}