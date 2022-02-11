// import 'package:amity_sdk/flutter_application_1.dart';
import 'dart:developer';

import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/core/error/amity_exception.dart';
import 'package:amity_sdk/public/public.dart';
import 'package:flutter/material.dart';

void main() {
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              TextButton(
                onPressed: () async {
                  AmityCoreClient.login('87')
                      .displayName('sorbh')
                      .deviceId('sorbh_device_id')
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
                      .getUser('87')
                      .then((value) {
                    log(value.toString());
                  }).onError<AmityException>((error, stackTrace) {
                    log(error.message.toString());
                  });
                },
                child: const Text('Get User by ID'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
