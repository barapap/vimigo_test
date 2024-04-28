import 'package:flutter/material.dart';

class SearchingBar extends StatefulWidget {
  final void Function(String) onChanged;

  const SearchingBar({super.key, required this.onChanged});

  @override
  SearchingBarState createState() => SearchingBarState();
}

class SearchingBarState extends State<SearchingBar> {
  late String _searchQuery;

  @override
  void initState() {
    super.initState();
    _searchQuery = '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search...',
            prefixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
            widget.onChanged(_searchQuery);
          },
        ),
      ),
    );
  }
}