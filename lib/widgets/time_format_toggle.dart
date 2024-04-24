import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeFormatToggle extends StatefulWidget{
  const TimeFormatToggle({super.key, required bool useTimeAgoFormat});

  @override
  TimeFormatToggleState createState() => TimeFormatToggleState();
}

class TimeFormatToggleState extends State<TimeFormatToggle> {
  bool _useTimeAgoFormat = true;

  final _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    _loadTimeFormatPreference();
  }

  void _loadTimeFormatPreference() async {
    final prefs = await _prefs;
    setState(() {
      _useTimeAgoFormat = prefs.getBool('useTimeAgoFormat') ?? true;
    });
  }

  void _saveTimeFormatPreference() async {
    final prefs = await _prefs;
    prefs.setBool('useTimeAgoFormat', _useTimeAgoFormat);
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: _useTimeAgoFormat,
      onChanged: (value) {
        setState(() {
          _useTimeAgoFormat = value;
        });
        _saveTimeFormatPreference();
      },
      title: const Text('Use "time ago" format'),
    );
  }
}