import 'package:flutter/material.dart';
import '../models/attendance_record.dart';

class AttendanceProvider with ChangeNotifier {
  final List<AttendanceRecord> _attendanceRecords = [];
  bool _useTimeAgoFormat = true;

  List<AttendanceRecord> get attendanceRecords => _attendanceRecords;
  bool get useTimeAgoFormat => _useTimeAgoFormat;

  void addAttendanceRecord(AttendanceRecord record) {
    _attendanceRecords.insert(0, record);
    notifyListeners();
  }

  void sortAttendanceRecords() {
    _attendanceRecords.sort((a, b) => b.time.compareTo(a.time));
    notifyListeners();
  }

  void toggleTimeAgoFormat() {
    _useTimeAgoFormat = !_useTimeAgoFormat;
    notifyListeners();
  }
}