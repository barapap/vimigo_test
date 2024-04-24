import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final void Function(String) onChanged;

  const SearchBar({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        onChanged: onChanged,
        decoration: const InputDecoration(
          hintText: 'Search...',
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}