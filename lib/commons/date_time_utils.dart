import 'package:intl/intl.dart';

class DateTimeUtils {
  static const defaultDateFormat = 'yyyy-MM-dd HH:mm';

  static const defaultDisplayDateFormat = 'MMM d, h:mm a';
  static const defaultDisplayDurationFormat = 'm:ss';

  static DateTime? tryParse(
    String? formattedString, {
    String dateFormat = defaultDateFormat,
    bool utc = false,
  }) =>
      formattedString != null
          ? DateFormat(
              dateFormat,
            ).parse(
              formattedString,
              utc,
            )
          : null;

  static String? formatDate(
    DateTime? date, {
    String dateFormat = defaultDateFormat,
  }) =>
      date != null
          ? DateFormat(
              dateFormat,
            ).format(
              date,
            )
          : null;

  static String? formatDisplayDate(
    DateTime? date, {
    String dateFormat = defaultDisplayDateFormat,
  }) =>
      formatDate(
        date?.toLocal(),
        dateFormat: dateFormat,
      );

  static String? formatDuration(
    Duration duration, {
    String dateFormat = defaultDisplayDurationFormat,
  }) =>
      formatDate(
        DateTime.fromMillisecondsSinceEpoch(
          duration.inMilliseconds,
          isUtc: true,
        ),
        dateFormat: dateFormat,
      );
}
