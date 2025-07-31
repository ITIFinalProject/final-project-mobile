
class MemoryModel{
   String eventId;
   String url;
   String type; // 'image' or 'video'
   MemoryModel({
      required this.eventId,
      required this.url,
      required this.type,
   });
    Map<String, dynamic> toMap() {
      return {
        'eventId': eventId,
        'url': url,
        'type': type,

      };
    }
    factory MemoryModel.fromMap(Map<String, dynamic> map) {
      return MemoryModel(
        eventId: map['eventId'],
        url:map['url'],
        type: map['type'],
      );
    }
     
}