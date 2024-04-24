class AttendanceRecord{
  final String id;
  final String name;
  final String contact;
  final DateTime time;

  AttendanceRecord({
    required this.id,
    required this.name,
    required this.contact,
    required this.time
  });

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) {
    return AttendanceRecord(
      id: json['id'],
      time: DateTime.parse(json['time']),
      name: json['name'],
      contact: json['contact'],
    );
  }
}