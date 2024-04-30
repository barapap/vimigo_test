import 'package:flutter/material.dart';

import '../providers/attendance_provider.dart';

class AddAttendanceRecordDialog extends StatefulWidget {
  final AttendanceProvider provider;
  final Function onRecordAdded;

  const AddAttendanceRecordDialog({super.key, required this.provider, required this.onRecordAdded});

  @override
  AddAttendanceRecordDialogState createState() => AddAttendanceRecordDialogState();
}

class AddAttendanceRecordDialogState extends State<AddAttendanceRecordDialog> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _contact = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Attendee'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Attendee\'s name';
                }
                return null;
              },
              onSaved: (value) {
                _name = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Contact'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter contact number';
                }
                return null;
              },
              onSaved: (value) {
                _contact = value!;
              },
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              widget.provider.addAttendanceRecord(_name, _contact);
              widget.onRecordAdded();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Record added successfully')),
              );
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}