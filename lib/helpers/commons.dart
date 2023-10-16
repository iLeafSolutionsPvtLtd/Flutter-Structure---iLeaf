// coverage:ignore-file
import 'package:intl/intl.dart';

class Commons {
  Commons._();

  static String getTimeFromDateAndTime(String date) {
    DateTime dateTime;
    try {
      dateTime = DateTime.parse(date).toLocal();
      return DateFormat.jm().format(dateTime);
      // String formattedTime = DateFormat.Hms().format(now);
      // String formattedTime = DateFormat.Hm().format(now);
    } catch (e) {
      return date;
    }
  }

  static String getDirectionFromAngle(int angle) {
    final val = ((angle / 22.5) + .5).toInt();
    final arr = [
      'N',
      'NNE',
      'NE',
      'ENE',
      'E',
      'ESE',
      'SE',
      'SSE',
      'S',
      'SSW',
      'SW',
      'WSW',
      'W',
      'WNW',
      'NW',
      'NNW',
    ];
    return arr[val % 16];
  }
}

enum Direction { right, bottom }
