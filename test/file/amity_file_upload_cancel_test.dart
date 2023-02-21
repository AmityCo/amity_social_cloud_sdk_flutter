import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockFileApiInterface extends Mock implements FileApiInterface {}

// integration_test_id:ab0bf137-df0d-48da-9265-7e0dee55ce33
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final fileApiInterface = MockFileApiInterface();

  const uploadProgressStep = [0, 10, 20, 30, 40, 50, 60];

  setUpAll(() async {
    registerFallbackValue(UploadFileRequest());

    await AmityCoreClientMockSetup.setup();
    await AmityCoreClientMockSetup.loadMockSession();

    serviceLocator.registerLazySingleton<FileApiInterface>(
      () => fileApiInterface,
    );
  });

  test(
      'When the user try to upload file and cancel in middle, it should return cancel event',
      () async {
    when(() => fileApiInterface.uploadFile(
          any(),
          onUploadProgress: any(named: 'onUploadProgress'),
          cancelToken: any(named: 'cancelToken'),
        )).thenAnswer((invocation) async {
      final namedArgs = invocation.namedArguments;

      final onUploadProgress = namedArgs[Symbol('onUploadProgress')]
          as Function(int progress, int total);

      // emulate in progress callback
      for (int progress in uploadProgressStep) {
        await Future.delayed(const Duration(milliseconds: 20));
        onUploadProgress(progress, 100);
      }

      return Future.error(DioError(
        type: DioErrorType.cancel,
        error: 'User Cancel the request',
        requestOptions: RequestOptions(path: ''),
      ));
    });

    final fileUpload = File('mock_path');
    AmityCoreClient.newFileRepository()
        .file(fileUpload)
        .upload()
        .stream
        .listen(expectAsync1((event) {
          event.when(
            progress: (uploadInfo, cancelToken) {
              final progress = uploadInfo.getProgressPercentage();
              print('Progress $progress');
            },
            complete: (file) {},
            error: (error) {},
            cancel: () {
              print('Cancel');
              expect(event, isA<AmityUploadCancel>());
            },
          );
        }, count: uploadProgressStep.length + 1));
  });

  tearDownAll(() async {
    await AmityCoreClient.logout();
  });
}
