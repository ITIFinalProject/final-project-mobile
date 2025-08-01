import 'package:equatable/equatable.dart';
import 'package:eventify_app/features/auth/models/user_model.dart';

class EventModel extends Equatable {
  final String id;

  final String category;
  final String title;
  final String description;
  final String date;
  final String time;
  final String location;
  final int capacity;
  final String? bannerUrl;
  final int? templateIndex;
  final String hostName;
  final String? hostId;
  final String type;
  final List<UserModel>? guests;

  const EventModel( {
    required this.hostName,
    required this.type,
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
    required this.capacity,
    required this.hostId,
    required this.category,
    this.bannerUrl,
    this.templateIndex,
    this.guests
  });

  // EventModel copyWith({
  //   String? id,
  //   String? type,
  //   String? title,
  //   String? description,
  //   String? date,
  //   String? time,
  //   String? location,
  //   int? capacity,
  //   String? bannerUrl,
  //   int? templateIndex,
  //   String? hostName,
  //   String? hostId,
  //
  // }) {
  //   return EventModel(
  //     id: id ?? this.id,
  //     title: title ?? this.title,
  //     type: type ?? this.type,
  //     description: description ?? this.description,
  //     date: date ?? this.date,
  //     time: time ?? this.time,
  //     location: location ?? this.location,
  //     capacity: capacity ?? this.capacity,
  //     hostName: hostName ?? this.hostName,
  //     hostId: hostId ?? this.hostId,
  //   );
  // }
 DateTime get eventEndDateTime {
  try {
    final dateParts = date.split(' - ');
    final timeParts = time.split(' - ');

    if (dateParts.length < 2 || timeParts.length < 2) return DateTime.now();

    final endDate = dateParts[1].trim(); // "31/07/2025"
    final endTime = timeParts[1].trim(); // "12:00 PM"

    final full = '$endDate $endTime'; // "31/07/2025 12:00 PM"

    return DateTime.parse(
      _formatToISO(full),
    );
  } catch (e) {
    return DateTime.now();
  }
}

String _formatToISO(String dateTime) {
  // from "31/07/2025 12:00 PM" to ISO string
  final parts = dateTime.split(' ');
  final dateParts = parts[0].split('/');
  final time = parts[1];
  final ampm = parts[2];

  int hour = int.parse(time.split(':')[0]);
  int minute = int.parse(time.split(':')[1]);

  if (ampm == 'PM' && hour != 12) hour += 12;
  if (ampm == 'AM' && hour == 12) hour = 0;

  final day = dateParts[0].padLeft(2, '0');
  final month = dateParts[1].padLeft(2, '0');
  final year = dateParts[2];

  return '$year-$month-${day}T${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:00';
}
 Map<String, dynamic> toMap() {
  final data = {
    'id': id,
    'title': title,
    'type': type,
    'description': description,
    'date': date,
    'time': time,
    'location': location,
    'capacity': capacity,
    'bannerUrl': bannerUrl,
    'templateIndex': templateIndex,
    'hostName': hostName,
    'hostId': hostId,
    'category': category,
  };

  // ✅ نضيف guests بس لو type = Private
  if (type.toLowerCase() == 'private' && guests != null) {
    data['guests'] = guests!.map((user) => user.toFireStore()).toList();
  }

  return data;
}

  // factory EventModel.fromMap(Map<String, dynamic> map) {
  //   return EventModel(
  //     id: map['id'],
  //     type: map['type'] ?? 'default',
  //     title: map['title'],
  //     description: map['description'],
  //     date: map['date'],
  //     time: map['time'],
  //     location: map['location'],
  //     capacity: map['capacity'],
  //     bannerUrl: map['bannerUrl'],
  //     templateIndex: map['templateIndex'],
  //     hostName: map['hostName'] ?? 'Unknown Host',
  //     hostId: map['hostId'] ?? '',
  //     // category: map['category'],
  //   );
  // }
  factory EventModel.fromMap(Map<String, dynamic> map) {
  return EventModel(
    id: (map['id'] ?? '').toString(),
    type: (map['type'] ?? 'default').toString(),
    title: (map['title'] ?? 'Untitled Event').toString(),
    description: (map['description'] ?? '').toString(),
    date: (map['date'] ?? '').toString(),
    time: (map['time'] ?? '').toString(),
    location: (map['location'] ?? '').toString(),
    capacity: (map['capacity'] is int)
        ? map['capacity']
        : int.tryParse(map['capacity']?.toString() ?? '0') ?? 0,
    bannerUrl: map['bannerUrl']?.toString(),
    templateIndex: map['templateIndex'] is int
        ? map['templateIndex']
        : int.tryParse(map['templateIndex']?.toString() ?? ''),
    hostName: (map['hostName'] ?? 'Unknown Host').toString(),
    hostId: map['hostId']?.toString() ?? '',
    category: map['category']?.toString() ?? '',
    // ✅ نقرأ guests بس لو type = Private
    guests: (map['type']?.toString().toLowerCase() == 'private' &&
            map['guests'] != null)
        ? List<UserModel>.from(
            (map['guests'] as List).map((e) => UserModel.fromFireStore(e)))
        : null,
  );
}

  @override
  List<Object?> get props => [
    id,
    type,
    title,
    description,
    date,
    time,
    location,
    capacity,
    bannerUrl,
    templateIndex,
    hostName,
    hostId,
    category,
  ];
}
