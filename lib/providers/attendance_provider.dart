import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../models/attendance_record.dart';
import 'package:vimigo_test/utils/times_ago.dart';

class AttendanceProvider with ChangeNotifier {
  final List<AttendanceRecord> _attendanceRecords = [];
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
      // Add default values from JSON dataset
      final jsonData = [
        {
          "user": "Chan Saw Lin",
          "phone": "0152131113",
          "check-in": "2020-06-30 16:10:05"
        },
        {
          "user": "Lee Saw Loy",
          "phone": "0161231346",
          "check-in": "2020-07-11 15:39:59"
        },
        {
          "user": "Khaw Tong Lin",
          "phone": "0158398109",
          "check-in": "2020-08-19 11:10:18"
        },
        {
          "user": "Lim Kok Lin",
          "phone": "0168279101",
          "check-in": "2020-08-19 11:11:35"
        },
        {
          "user": "Low Jun Wei",
          "phone": "0112731912",
          "check-in": "2020-08-15 13:00:05"
        },
        {
          "user": "Yong Weng Kai",
          "phone": "0172332743",
          "check-in": "2020-07-31 18:10:11"
        },
        {
          "user": "Jayden Lee",
          "phone": "0191236439",
          "check-in": "2020-08-22 08:10:38"
        },
        {
          "user": "Kong Kah Yan",
          "phone": "0111931233",
          "check-in": "2020-07-11 12:00:00"
        },
        {
          "user": "Jasmine Lau",
          "phone": "0162879190",
          "check-in": "2020-08-01 12:10:05"
        },
        {
          "user": "Chan Saw Lin",
          "phone": "016783239",
          "check-in": "2020-08-23 11:59:05"
        }
      ];

      for (final json in jsonData) {
        final name = json['user']?? '';
        final phone = json['phone']?? '';
        final checkInString = json['check-in']?? '';
        final checkIn = DateTime.parse(checkInString);

        final newRecord = AttendanceRecord(
          name: name,
          contact: phone,
          time: useTimeAgoFormat ? DateTime.now().subtract(checkIn.difference(DateTime.now()).abs()) : checkIn.toUtc(),
        );
        _attendanceRecords.add(newRecord);
      }

      _attendanceRecords.sort((a, b) => b.time.compareTo(a.time));
    }

    _isLoading = false;
    notifyListeners();
  }
}