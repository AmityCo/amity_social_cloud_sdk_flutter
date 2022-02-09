// import 'package:amity_sdk/flutter_application_1.dart';
import 'package:amity_sdk/core/core.dart';
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
          child: TextButton(
              onPressed: () async {
                AmityPost amityPost =
                    await AmitySocialClient.newPostRepository()
                        .getPost('postId')
                        .get();
                print(amityPost.id);
              },
              child: Text('Test')),
        ),
      ),
    );
  }
}
