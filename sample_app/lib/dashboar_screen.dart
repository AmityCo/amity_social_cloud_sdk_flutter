import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextButton(
            onPressed: () {},
            child: const Text('User Profile'),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Global Feed'),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('My Feed'),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('User Feed'),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Community Feed'),
          ),
        ],
      ),
    );
  }
}
