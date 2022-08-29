// import 'package:amity_sdk/src/src.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:hive_test/hive_test.dart';

// void main() {
//   group('Message Query Test', () {
//     // 1.
//     setUp(() async {
//       WidgetsFlutterBinding.ensureInitialized();
//       await setUpTestHive();
//       await AmityCoreClient.setup(
//         option: AmityCoreClientOption(
//             apiKey: 'b0eeed0f3fd3f5614b31894d560e1688845adeeabe3c3d25',
//             httpEndpoint: AmityRegionalHttpEndpoint.values
//                 .where((element) => element.value == 'https://api.sg.amity.co/')
//                 .first,
//             showLogs: true),
//         sycInitialization: true,
//       );
//       await AmityCoreClient.login('bb01').submit();
//     });

//     // 2.
//     test('Message Query test', () async {});

//     // 3.
//     tearDown(() async {
//       await tearDownTestHive();
//     });
//   });
// }
