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

  factory AdvanceEntry.fromJson(Map<String, dynamic> json) {
    return AdvanceEntry(
      id: json['id'] as String? ?? '${DateTime.now().millisecondsSinceEpoch}',
      date: DateTime.parse(json['date'] as String),
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      note: json['note'] as String? ?? '',
      status: _parseStatus(json['status'] as String? ?? 'pending'),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date.toIso8601String(),
        'amount': amount,
        'note': note,
        'status': status.name,
      };

  static AdvanceStatus _parseStatus(String value) {
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
