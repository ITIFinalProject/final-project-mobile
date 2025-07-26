import 'package:equatable/equatable.dart';

class EventModel extends Equatable {
  final String id;
  final String type;
  final String title;
  final String description;
  final String date;
  final String time;
  final String location;
  final int capacity;
  final String? image;
  final int? templateIndex;
final String hosteName;
  const EventModel(  {
   required this.hosteName,
    required this.type,
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
    required this.capacity,
     this.image,
    this.templateIndex,
  });

  EventModel copyWith({
    String? id,
    String? type,
    String? title,
    String? description,
    String? date,
    String? time,
    String? location,
    int? capacity,
    String? image,
    int? templateIndex,
    String? hosteName
  }) {
    return EventModel(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      description: description ?? this.description,
      date: date ?? this.date,
      time: time ?? this.time,
      location: location ?? this.location,
      capacity: capacity ?? this.capacity,
      hosteName: hosteName ?? this.hosteName
    );


  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'description': description,
      'date': date,
      'time': time,
      'location': location,
      'capacity': capacity,
      'image': image,
      'templateIndex': templateIndex,
      'hosteName': hosteName
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      id: map['id'],
      type: map['type'] ?? 'default',
      title: map['title'],
      description: map['description'],
      date: map['date'],
      time: map['time'],
      location: map['location'],
      capacity: map['capacity'],
      image: map['image'],
      templateIndex: map['templateIndex'],
      hosteName: map['hosteName'] ?? 'Unknown Host',
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
        image,
        templateIndex,
        hosteName
      ];
}
