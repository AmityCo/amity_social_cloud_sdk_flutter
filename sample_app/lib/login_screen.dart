import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/public/public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1_example/core/route/app_route.dart';
import 'package:flutter_application_1_example/dashboar_screen.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userIdTextController = TextEditingController();
  final _displayNameTextController = TextEditingController();
  final _apiKeyTextController = TextEditingController();
  final _serverUrlTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // if (kDebugMode) {
    _userIdTextController.text = 'victimAndroid';
    _displayNameTextController.text = 'Victim Android';
    _apiKeyTextController.text =
        'b3bee858328ef4344a308e4a5a091688d05fdee2be353a2b';
    _serverUrlTextController.text = AmityRegionalHttpEndpoint.STAGING.value;
    // }

    ThemeData _themeData = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Text('ASC Flutter SDK', style: _themeData.textTheme.headline6),
              const SizedBox(height: 24),
              TextFormField(
                controller: _userIdTextController,
                decoration: const InputDecoration(
                  label: Text('User Id'),
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _displayNameTextController,
                decoration: const InputDecoration(
                  label: Text('Display name'),
                ),
              ),
              const SizedBox(height: 48),
              TextFormField(
                controller: _apiKeyTextController,
                decoration: const InputDecoration(
                  label: Text('Api Key'),
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _serverUrlTextController,
                decoration: const InputDecoration(
                  label: Text('Server url'),
                ),
              ),
              const SizedBox(height: 48),
              TextButton(
                onPressed: () async {
                  // Setup the Amity Option First
                  String apikey = _apiKeyTextController.text.trim();
                  String serverUrl = _serverUrlTextController.text.trim();
                  final data = await AmityCoreClient.setup(
                    option: AmityCoreClientOption(
                        apiKey: apikey,
                        httpEndpoint: AmityRegionalHttpEndpoint.values
                            .where((element) => element.value == serverUrl)
                            .first,
                        showLogs: true),
                    sycInitialization: true,
                  );

                  print(data.toString());

                  // await Future.delayed(Duration(seconds: 1));

                  //Login the user
                  String userId = _userIdTextController.text.trim();
                  String userDisplayName =
                      _displayNameTextController.text.trim();
                  await AmityCoreClient.login(userId)
                      .displayName(userDisplayName)
                      .deviceId('sorbh_device_id_88')
                      .submit();

                  GoRouter.of(context).go(AppRoute.homeRoute);
                  // Go.of(context).Navigator.of(context).pushReplacement(
                  //       MaterialPageRoute(
                  //         builder: (context) => const DashboardScreen(),
                  //       ),
                  //     );
                },
                child: Container(
                  width: 200,
                  alignment: Alignment.center,
                  child: const Text('Login'),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  primary: Colors.white,
                  padding: const EdgeInsets.all(12),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
