import 'package:amity_sdk/public/amity_core_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final amityUser = AmityCoreClient.getCurrentUser();
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.grey.withOpacity(.3)),
                child: Image.network(
                  amityUser.avatarCustomUrl!,
                  fit: BoxFit.fill,
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
              ),
              const SizedBox(height: 20),
              Text('UserId - ${amityUser.userId}'),
              const SizedBox(height: 8),
              Text('Display name - ${amityUser.displayName}'),
              const SizedBox(height: 8),
              Text('Created Date - ${amityUser.createdAt}'),
              const SizedBox(height: 40),
              Text('Updated Date - ${amityUser.updatedAt}'),
              const SizedBox(height: 8),
              Text('Meta Data - ${amityUser.metadata}'),
            ],
          ),
        ),
      ),
    );
  }
}
