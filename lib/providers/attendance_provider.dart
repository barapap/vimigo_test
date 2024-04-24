import 'package:flutter/material.dart';
import 'package:vimigo_test/models/attendance_record.dart';

class AttendanceProvider with ChangeNotifier {
  final List<AttendanceRecord> _attendanceRecords = [];
  int _selectedIndex = -1;
  AttendanceRecord? _selectedAttendee;
  bool _useTimeAgoFormat = true;

  List<AttendanceRecord> get attendanceRecords => _attendanceRecords;
  int get selectedIndex => _selectedIndex;
  AttendanceRecord? get selectedAttendee => _selectedAttendee;
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

  void selectAttendee(AttendanceRecord attendee){
    _selectedAttendee = attendee;
    _selectedIndex = _attendanceRecords.indexOf(attendee);
    notifyListeners();
  }

  void deselectAttendee() {
    _selectedAttendee = null;
    _selectedIndex = -1;
    notifyListeners();
  }
}