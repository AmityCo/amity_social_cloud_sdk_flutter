import 'package:amity_sdk/amity_sdk.dart';
import 'package:flutter/material.dart';

void main() async {
  ///Setup Amity Core client with [apikey] and the region you want to connect with
  ///
  ///By default AmityCoreClient will connect to AmityRegionalHttpEndpoint.SG.
  ///If you want to change the region you can do so by passing httpEndpoint parameter:
  await AmityCoreClient.setup(
      option: AmityCoreClientOption(
          apiKey: 'apiKey', httpEndpoint: AmityRegionalHttpEndpoint.SG));
  runApp(const AmitySocialSdk());
}

class AmitySocialSdk extends StatelessWidget {
  const AmitySocialSdk({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amity Social Sdk Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(title: 'Flutter Demo Home Page'),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Here is the Login Example with Amity Social SDK',
            ),
            ElevatedButton(
                onPressed: () {
                  ///Login the user with user id and display name
                  ///
                  ///this will create the session for the logged in user
                  AmityCoreClient.login('userId')
                      .displayName('userDisplayName')
                      .submit();
                },
                child: const Text('Login'))
          ],
        ),
      ),
    );
  }
}
