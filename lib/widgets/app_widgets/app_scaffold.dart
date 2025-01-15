import 'package:flutter/material.dart';
import 'package:society_management/theme/app_colors.dart';
import '../misc/drawer/drawer_widget.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  const AppScaffold({super.key, required this.body, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(
          // size: 40, // Change the size as needed
          color: Colors.white, // Change the color as neede
        ),
      ),
      drawer: DrawerWidget(),
      drawerEnableOpenDragGesture: true,
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
        child: body,
      ),
    );
  }
}
