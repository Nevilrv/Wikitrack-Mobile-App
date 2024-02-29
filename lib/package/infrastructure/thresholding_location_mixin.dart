import 'dart:collection';

import 'package:wikitrack/package/core/i_lat_lng.dart';
import 'package:wikitrack/package/core/i_location_dispatcher.dart';
import 'package:wikitrack/package/helpers/spherical_util.dart';

mixin ThresholdingLocation on ILocationDispatcher {
  DoubleLinkedQueueEntry<ILatLng> thresholding(DoubleLinkedQueueEntry<ILatLng> entry) {
    var current = entry.element;

    var nextEntry = entry.nextEntry();
    var upcomingEntry = nextEntry?.nextEntry();

    var next = nextEntry?.element ?? ILatLng.empty();
    var upcoming = upcomingEntry?.element ?? ILatLng.empty();

    if (upcoming.isNotEmpty) {
      var currentBearing = SphericalUtil.computeHeading(current, next);

      var upComingBearing = SphericalUtil.computeHeading(next, upcoming);

      var delta = upComingBearing - currentBearing;

      if (delta.abs() < threshold) {
        nextEntry!.remove();
      }
    }

    return entry;
  }
}
