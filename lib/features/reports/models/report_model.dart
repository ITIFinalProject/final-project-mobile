class ReportModel {
  final String eventId;
  final String eventTitle;
  final String eventHostId;
  final String reporterId;
  final String reporterName;
  final String reason;
  final String? customReason;
  final String description;
  final String? evidenceImageUrl;
  final String status;
  final DateTime createdAt;

  ReportModel({
    required this.eventId,
    required this.eventTitle,
    required this.eventHostId,
    required this.reporterId,
    required this.reporterName,
    required this.reason,
    this.customReason,
    required this.description,
    this.evidenceImageUrl,
    this.status = 'pending',
    required this.createdAt,
  });

  ReportModel copyWith({
    String? eventId,
    String? eventTitle,
    String? eventHostId,
    String? reporterId,
    String? reporterName,
    String? reason,
    String? customReason,
    String? description,
    String? evidenceImageUrl,
    String? status,
    DateTime? createdAt,
  }) {
    return ReportModel(
      eventId: eventId ?? this.eventId,
      eventTitle: eventTitle ?? this.eventTitle,
      eventHostId: eventHostId ?? this.eventHostId,
      reporterId: reporterId ?? this.reporterId,
      reporterName: reporterName ?? this.reporterName,
      reason: reason ?? this.reason,
      customReason: customReason ?? this.customReason,
      description: description ?? this.description,
      evidenceImageUrl: evidenceImageUrl ?? this.evidenceImageUrl,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'eventId': eventId,
      'eventTitle': eventTitle,
      'eventHostId': eventHostId,
      'reporterId': reporterId,
      'reporterName': reporterName,
      'reason': reason,
      'customReason': customReason,
      'description': description,
      'evidenceImageUrl': evidenceImageUrl,
      'status': status,
      'createdAt': createdAt,
    };
  }
}
