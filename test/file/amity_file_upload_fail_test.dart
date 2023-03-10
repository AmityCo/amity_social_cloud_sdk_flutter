import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockFileApiInterface extends Mock implements FileApiInterface {}

// integration_test_id:8411b533-e8c2-4d19-9318-e5bfcfc8cfba
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final fileApiInterface = MockFileApiInterface();

  setUpAll(() async {
    registerFallbackValue(UploadFileRequest());

    await AmityCoreClientMockSetup.setup();
    await AmityCoreClientMockSetup.loadMockSession();

    serviceLocator.registerLazySingleton<FileApiInterface>(
      () => fileApiInterface,
    );
  });

  test(
      'When the user try to upload file and fail in middle, it should return amity error event',
      () async {
    when(() => fileApiInterface.uploadFile(
          any(),
          onUploadProgress: any(named: 'onUploadProgress'),
          cancelToken: any(named: 'cancelToken'),
        )).thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 2));
      throw AmityException(message: 'Upload failed', code: 1234);
    });

    final fileUpload = File('mock_path');
    AmityCoreClient.newFileRepository().file(fileUpload).upload().stream.listen(
      expectAsync1(
        (event) {
          event.when(
            progress: (uploadInfo, cancelToken) {},
            complete: (file) {},
            error: (error) {
              expect(event, isA<AmityUploadError>());
              expect(error, isA<AmityException>());
            },
            cancel: () {},
          );
        },
      ),
    );
  });

  tearDownAll(() async {
    await AmityCoreClient.logout();
  });
}
