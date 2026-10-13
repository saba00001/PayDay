enum AdvanceStatus { pending, approved, rejected }

class AdvanceEntry {
  AdvanceEntry({
    required this.id,
    required this.date,
    required this.amount,
    required this.note,
    required this.status,
  });

  final String id;
  final DateTime date;
  final double amount;
  final String note;
  final AdvanceStatus status;

  AdvanceEntry copyWith({
    String? id,
    DateTime? date,
    double? amount,
    String? note,
    AdvanceStatus? status,
  }) {
    return AdvanceEntry(
      id: id ?? this.id,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      note: note ?? this.note,
      status: status ?? this.status,
    );
  }

  factory AdvanceEntry.fromJson(Map<String, dynamic> json) {
    return AdvanceEntry(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      amount: (json['amount'] as num).toDouble(),
      note: json['note'] as String? ?? '',
      status: _statusFromString(json['status'] as String? ?? 'pending'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'amount': amount,
      'note': note,
      'status': status.name,
    };
  }

  static AdvanceStatus _statusFromString(String value) {
    switch (value) {
      case 'approved':
        return AdvanceStatus.approved;
      case 'rejected':
        return AdvanceStatus.rejected;
      default:
        return AdvanceStatus.pending;
    }
  }

  static String statusLabel(AdvanceStatus status) {
    switch (status) {
      case AdvanceStatus.pending:
        return 'მოლოდინში';
      case AdvanceStatus.approved:
        return 'დადასტურებული';
      case AdvanceStatus.rejected:
        return 'უარყოფილი';
    }
  }
}
