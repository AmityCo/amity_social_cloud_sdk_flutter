import 'package:amity_sdk/public/public.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1_example/user_profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const UserProfileScreen(),
                    ),
                  );
                },
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
              TextButton(
                onPressed: () {
                  AmityCoreClient.registerDeviceNotification("blah");
                },
                child: const Text('Register notification'),
              ),
              TextButton(
                onPressed: () {
                  AmityCoreClient.unregisterDeviceNotification();
                },
                child: const Text('Unregister notification'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
