String timeFormat(final DateTime time) =>
    '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
String dateFormat(final DateTime date) =>
    '${date.day.toString().padLeft(2, '0')}:${date.month.toString().padLeft(2, '0')}:${date.year.toString().padLeft(2, '0')}';
String dateTimeFormat(final DateTime dt) =>
    '${timeFormat(dt)} ${dateFormat(dt)}';
