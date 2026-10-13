class WorkDay {
  WorkDay({
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.hours,
    required this.rate,
    required this.total,
    required this.note,
  });

  final DateTime date;
  final String startTime;
  final String endTime;
  final double hours;
  final double rate;
  final double total;
  final String note;

  factory WorkDay.fromJson(Map<String, dynamic> json) {
    return WorkDay(
      date: DateTime.parse(json['date'] as String),
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      hours: (json['hours'] as num).toDouble(),
      rate: (json['rate'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      note: json['note'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'startTime': startTime,
      'endTime': endTime,
      'hours': hours,
      'rate': rate,
      'total': total,
      'note': note,
    };
  }

  static double calculateHours(String start, String end) {
    final startParts = start.split(':');
    final endParts = end.split(':');

    if (startParts.length != 2 || endParts.length != 2) {
      return 0;
    }

    final startMinutes = (int.parse(startParts[0]) * 60) + int.parse(startParts[1]);
    final endMinutes = (int.parse(endParts[0]) * 60) + int.parse(endParts[1]);

    final diff = endMinutes - startMinutes;
    if (diff <= 0) return 0;

    return diff / 60.0;
  }
}
