import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vimigo_test/models/attendance_record.dart';
import 'package:vimigo_test/providers/attendance_provider.dart';
import 'package:vimigo_test/widgets/attendance_record_details.dart';
import 'package:vimigo_test/widgets/attendance_record_list.dart';
import 'package:vimigo_test/widgets/starting_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool useTimeAgoFormat = prefs.getBool('useTimeAgoFormat') ?? true;
  runApp(MyApp(useTimeAgoFormat: useTimeAgoFormat));
}

class MyApp extends StatelessWidget {
  final bool useTimeAgoFormat;

  const MyApp({super.key, required this.useTimeAgoFormat});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AttendanceProvider()),
      ],
      child: MaterialApp(
        title: 'Attendance App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const StartingScreen(),
        routes: {
          AttendanceRecordList.routeName: (context) => AttendanceRecordList(useTimeAgoFormat: useTimeAgoFormat),
          AttendanceRecordDetails.routeName: (context) => AttendanceRecordDetails(record: ModalRoute.of(context)!.settings.arguments as AttendanceRecord),
        },
      ),
    );
  }
}