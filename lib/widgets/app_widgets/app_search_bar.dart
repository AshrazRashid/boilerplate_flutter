import 'dart:async';
import 'package:flutter/material.dart';
import 'package:society_management/theme/app_colors.dart';
import 'package:society_management/widgets/misc/reuseable_widget.dart';

class AppSearchBar extends StatefulWidget {
  final double? width;
  final double height;
  final Function(String) onChanged;

  const AppSearchBar(
      {super.key, this.width, this.height = 60, required this.onChanged});

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  Timer? _debounce;
  final Duration _debounceDuration = const Duration(milliseconds: 500);
  final _searchController = TextEditingController();
  var search = "";

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(_debounceDuration, () {
      // Place your search logic here
      print('Search term: $query');

      widget.onChanged(query);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black12),
          borderRadius: BorderRadius.circular(5)),
      child: TextField(
        controller: _searchController,
        style: const TextStyle(fontSize: 13),
        onChanged: (value) {
          setState(() {
            search = value;
          });
          _onSearchChanged(value);
        },
        cursorColor: AppColors.primary,
        decoration: InputDecoration(
            prefixIcon: Padding(
                padding: const EdgeInsets.all(16),
                child: ReusableWidget.loadSvg("search", color: Colors.black45)),
            hintText: "Search",
            filled: true,
            fillColor: const Color(0xFFF5F6F8),
            suffixIcon: search.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      _searchController.text = "";
                      search = "";
                      widget.onChanged("");
                      setState(() {});
                    },
                    icon: const Icon(Icons.clear))
                : null,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none)),
      ),
    );
  }
}
