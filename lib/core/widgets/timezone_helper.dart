import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzData;

class TimezoneHelper {
  static bool _initialized = false;

  static Future<void> initialize() async {
    if (!_initialized) {
      tzData.initializeTimeZones();
      final egypt = tz.getLocation('Africa/Cairo');
      tz.setLocalLocation(egypt);
      _initialized = true;
    }
  }

  static tz.TZDateTime createCairoDateTime(
      DateTime date, int hour, int minute) {
    final location = tz.getLocation('Africa/Cairo');
    return tz.TZDateTime(
        location, date.year, date.month, date.day, hour, minute);
  }
}
