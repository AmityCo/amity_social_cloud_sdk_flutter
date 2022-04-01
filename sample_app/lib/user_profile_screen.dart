import 'package:amity_sdk/public/amity_core_client.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  int _currentTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    final _themeData = Theme.of(context);
    final amityUser = AmityCoreClient.getCurrentUser();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('User Profile')),
        body: Container(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(.3)),
                    child: amityUser.avatarCustomUrl != null
                        ? Image.network(
                            amityUser.avatarCustomUrl!,
                            fit: BoxFit.fill,
                          )
                        : Image.asset(
                            'packages/amity_sdk/assets/user_placeholder.png'),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    '${amityUser.userId}',
                    style: _themeData.textTheme.headline5!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Display name - ${amityUser.displayName}',
                style: _themeData.textTheme.subtitle1!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Text('Description - ${amityUser.description}'),
              const SizedBox(height: 8),
              Text('Created Date - ${amityUser.createdAt}'),
              const SizedBox(height: 8),
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
