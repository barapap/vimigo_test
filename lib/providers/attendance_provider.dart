import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../models/attendance_record.dart';
import 'package:vimigo_test/utils/times_ago.dart';

class AttendanceProvider with ChangeNotifier {
  final List<AttendanceRecord> _attendanceRecords = [];

  final defaultRecords = [
    AttendanceRecord(
      name: "Chan Saw Lin",
      contact: "0152131113",
      time: DateTime.parse("2020-06-30 16:10:05"),
    ),
    AttendanceRecord(
      name: "Lee Saw Loy",
      contact: "0161231346",
      time: DateTime.parse("2020-07-11 15:39:59"),
    ),
    AttendanceRecord(
      name: "Khaw Tong Lin",
      contact: "0158398109",
      time: DateTime.parse("2020-08-19 11:10:18"),
    ),
    AttendanceRecord(
      name: "Lim Kok Lin",
      contact: "0168279101",
      time: DateTime.parse("2020-08-19 11:11:35"),
    ),
    AttendanceRecord(
      name: "Low Jun Wei",
      contact: "0112731912",
      time: DateTime.parse("2020-08-15 13:00:05"),
    ),
    AttendanceRecord(
      name: "Yong Weng Kai",
      contact: "0172332743",
      time: DateTime.parse("2020-07-31 18:10:11"),
    ),
    AttendanceRecord(
      name: "Jayden Lee",
      contact: "0191236439",
      time: DateTime.parse("2020-08-22 08:10:38"),
    ),
    AttendanceRecord(
      name: "Kong Kah Yan",
      contact: "0111931233",
      time: DateTime.parse("2020-07-11 12:00:00"),
    ),
    AttendanceRecord(
      name: "Jasmine Lau",
      contact: "0162879190",
      time: DateTime.parse("2020-08-01 12:10:05"),
    ),
    AttendanceRecord(
      name: "Chan Saw Lin",
      contact: "016783239",
      time: DateTime.parse("2020-08-23 11:59:05"),
    ),
  ];

  bool _useTimeAgoFormat = true;
  bool _isLoading = false;
  String _searchQuery = '';

  List<AttendanceRecord> get attendanceRecords => _attendanceRecords;

  bool get useTimeAgoFormat => _useTimeAgoFormat;

  bool get isLoading => _isLoading;

  String? get searchText => _searchQuery;

  set searchText(String? newSearchText) {
    _searchQuery = newSearchText?? '';
    notifyListeners();
  }

  List<AttendanceRecord> get filteredAttendanceRecords {
    if (_searchQuery.isEmpty) {
      return attendanceRecords;
    }
    return attendanceRecords
        .where((record) => record.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  void searchAttendanceRecords(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void toggleTimeFormat(bool shouldFetchRecords) {
    _useTimeAgoFormat = !_useTimeAgoFormat; // Toggle the flag
    if (shouldFetchRecords) {
      fetchAttendanceRecords();
    }
    notifyListeners(); // Notify listeners of the change
  }

  String formatTime(DateTime time) {
    if (_useTimeAgoFormat) {
      return timeAgo(time);
    } else {
      final truncatedTime = time.subtract(Duration(milliseconds: time.millisecond));
      return DateFormat('dd MMM yyyy, h:mm a').format(truncatedTime);
    }
  }

  void addAttendanceRecord(String name, String contact) {
    final newRecord = AttendanceRecord(
      name: name,
      contact: contact,
      time: useTimeAgoFormat ? DateTime.now() : DateTime.now().toUtc(),
    );

    _attendanceRecords.insert(0, newRecord);
    _attendanceRecords.sort((a, b) => b.time.compareTo(a.time));
    notifyListeners();
  }

  Future<void> fetchAttendanceRecords() async {
    _isLoading = true;
    notifyListeners();

    // Simulate fetching data from an API
    await Future.delayed(const Duration(seconds: 1));

    if (_attendanceRecords.isEmpty) {
      _attendanceRecords.addAll(defaultRecords.map((record) => AttendanceRecord(
        name: record.name,
        contact: record.contact,
        time: record.time,
      )).toList());
      _attendanceRecords.sort((a, b) => b.time.compareTo(a.time));
    }

    _isLoading = false;
    notifyListeners();
  }
}