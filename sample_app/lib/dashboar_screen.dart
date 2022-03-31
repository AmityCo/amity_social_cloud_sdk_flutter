import 'package:amity_sdk/public/amity_core_client.dart';
import 'package:amity_sdk/public/public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1_example/create_post_screen.dart';
import 'package:flutter_application_1_example/global_feed_screen.dart';
import 'package:flutter_application_1_example/login_screen.dart';
import 'package:flutter_application_1_example/user_feed_screen.dart';
import 'package:flutter_application_1_example/user_profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final _themeData = Theme.of(context);
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
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CreatePostScreen(),
                    ),
                  );
                },
                child: const Text('Create Post'),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const GlobalFeedScreen(),
                    ),
                  );
                },
                child: const Text('Global Feed'),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UserFeedScreen(
                          userId: AmityCoreClient.getCurrentUser().userId!),
                    ),
                  );
                },
                child: const Text('My Feed'),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          const UserFeedScreen(userId: 'victimIOS'),
                    ),
                  );
                },
                child: const Text('User Feed'),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {},
                child: const Text('Community Feed'),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  AmityCoreClient.registerDeviceNotification("blah");
                },
                child: const Text('Register notification'),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  AmityCoreClient.unregisterDeviceNotification();
                },
                child: const Text('Unregister notification'),
              ),
              const SizedBox(height: 200),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (route) => false,
                  );
                },
                child: Text(
                  'Logout',
                  style: _themeData.textTheme.subtitle1!
                      .copyWith(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
