// import 'package:amity_sdk/flutter_application_1.dart';
import 'dart:developer';

import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/core/error/amity_exception.dart';
import 'package:amity_sdk/public/public.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    AmityCoreClient.setup(
        option: AmityCoreClientOption(
            apiKey: 'b3bee858328ef4344a308e4a5a091688d05fdee2be353a2b',
            httpEndpoint: AmityRegionalHttpEndpoint.STAGING));
  }

  late String userId;
  late String userDisplayName;
  @override
  Widget build(BuildContext context) {
    userId = 'victimAndroid';
    userDisplayName = 'victimAndroid';
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: ListView(
            children: [
              TextButton(
                onPressed: () async {
                  AmityCoreClient.login(userId)
                      .displayName(userDisplayName)
                      .deviceId('sorbh_device_id_88')
                      .submit()
                      .then((value) {
                    log(value.displayName!);
                  }).onError<AmityException>((error, stackTrace) {
                    log(error.message.toString());
                  });
                },
                child: const Text('Login'),
              ),
              TextButton(
                onPressed: () async {
                  AmityCoreClient.newUserRepository()
                      .getUsers()
                      .query()
                      .then((value) {
                    log(value.toString());
                  }).onError<AmityException>((error, stackTrace) {
                    log(error.message.toString());
                  });
                },
                child: const Text('Get All User'),
              ),
              TextButton(
                onPressed: () async {
                  AmityCoreClient.newUserRepository()
                      .getUser('victimiOS')
                      .then((value) {
                    log(value.toString());
                  }).onError<AmityException>((error, stackTrace) {
                    log(error.message.toString());
                  });
                },
                child: const Text('Get User by ID'),
              ),
              TextButton(
                onPressed: () async {
                  AmityCoreClient.newUserRepository()
                      .searchUserByDisplayName('sor')
                      .query()
                      .then((value) {
                    log(value.toString());
                  }).onError<AmityException>((error, stackTrace) {
                    log(error.message.toString());
                  });
                },
                child: const Text('Search User by Display Name'),
              ),
              TextButton(
                onPressed: () async {
                  AmityCoreClient.newUserRepository()
                      .relationship()
                      .user('87')
                      .follow()
                      .then((value) {
                    log('Follow 87');
                    // log(value.toString());
                  }).onError<AmityException>((error, stackTrace) {
                    log(error.message.toString());
                  });
                },
                child: const Text('Follow user 87'),
              ),
              TextButton(
                onPressed: () async {
                  AmityCoreClient.newUserRepository()
                      .relationship()
                      .me()
                      .unfollow('87')
                      .then((value) {
                    log('Unfollow 87');
                    // log(value.toString());
                  }).onError<AmityException>((error, stackTrace) {
                    log(error.message.toString());
                  });
                },
                child: const Text('Unfollow user 87'),
              ),
              TextButton(
                onPressed: () async {
                  AmityCoreClient.newUserRepository()
                      .relationship()
                      .me()
                      .accept('88')
                      .then((value) {
                    log('Accept 88');
                    // log(value.toString());
                  }).onError<AmityException>((error, stackTrace) {
                    log(error.message.toString());
                  });
                },
                child: const Text('Accept Follow Request 88'),
              ),
              TextButton(
                onPressed: () async {
                  AmityCoreClient.newUserRepository()
                      .relationship()
                      .me()
                      .decline('88')
                      .then((value) {
                    log('Decline 88');
                    // log(value.toString());
                  }).onError<AmityException>((error, stackTrace) {
                    log(error.message.toString());
                  });
                },
                child: const Text('Decline Follow Request 88'),
              ),
              TextButton(
                onPressed: () async {
                  AmityCoreClient.newUserRepository()
                      .relationship()
                      .me()
                      .getFollowInfo()
                      .then((value) {
                    log('Decline 88');
                    // log(value.toString());
                  }).onError<AmityException>((error, stackTrace) {
                    log(error.message.toString());
                  });
                },
                child: const Text('Follow Info me'),
              ),
              TextButton(
                onPressed: () async {
                  AmityCoreClient.newUserRepository()
                      .relationship()
                      .user('87')
                      .getFollowInfo()
                      .then((value) {
                    log('Decline 88');
                    // log(value.toString());
                  }).onError<AmityException>((error, stackTrace) {
                    log(error.message.toString());
                  });
                },
                child: const Text('Follow Info 87'),
              ),
              TextButton(
                onPressed: () async {
                  AmityCoreClient.newUserRepository()
                      .relationship()
                      .me()
                      .getFollowers()
                      .query()
                      .then((value) {
                    log(value.toString());
                    // log(value.toString());
                  }).onError<AmityException>((error, stackTrace) {
                    log(error.message.toString());
                  });
                },
                child: const Text('Get my follower'),
              ),
              TextButton(
                onPressed: () async {
                  AmityCoreClient.newUserRepository()
                      .relationship()
                      .me()
                      .getFollowings()
                      .query()
                      .then((value) {
                    log(value.toString());
                    // log(value.toString());
                  }).onError<AmityException>((error, stackTrace) {
                    log(error.message.toString());
                  });
                },
                child: const Text('Get my following'),
              ),
              TextButton(
                onPressed: () async {
                  AmityCoreClient.newUserRepository()
                      .relationship()
                      .user('victimiOS')
                      .getFollowers()
                      .query()
                      .then((value) {
                    log(value.toString());
                    // log(value.toString());
                  }).onError<AmityException>((error, stackTrace) {
                    log(error.message.toString());
                  });
                },
                child: const Text('Get victimiOS followers'),
              ),
              TextButton(
                onPressed: () async {
                  AmityCoreClient.newUserRepository()
                      .relationship()
                      .user('victimiOS')
                      .getFollowings()
                      .query()
                      .then((value) {
                    log(value.toString());
                    // log(value.toString());
                  }).onError<AmityException>((error, stackTrace) {
                    log(error.message.toString());
                  });
                },
                child: const Text('Get victimiOS following'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
