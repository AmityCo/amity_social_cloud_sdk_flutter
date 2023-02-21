import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockFileApiInterface extends Mock implements FileApiInterface {}

// integration_test_id:248560a2-950e-454a-94d5-56203b38e6f1
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final fileApiInterface = MockFileApiInterface();

  const uploadProgressStep = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100];

  setUpAll(() async {
    registerFallbackValue(UploadFileRequest());

    await AmityCoreClientMockSetup.setup();
    await AmityCoreClientMockSetup.loadMockSession();

    serviceLocator.registerLazySingleton<FileApiInterface>(
      () => fileApiInterface,
    );
  });

  test(
      'When the user try to upload file, it should return sucess with upload process',
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
        await Future.delayed(const Duration(milliseconds: 200));
        onUploadProgress(progress, 100);
      }

      final response =
          await File('test/mock_json/amity_file_upload.json').readAsString();

      return fileResponseFromList(json.decode(response));
    });

    final fileUpload = File('mock_path');
    int callbackCount = 0;
    AmityCoreClient.newFileRepository()
        .file(fileUpload)
        .upload()
        .stream
        .listen(expectAsync1((event) {
          event.when(
            progress: (uploadInfo, cancelToken) {
              expect(event, isA<AmityUploadInProgress>());
              expect(uploadInfo, isA<AmityUploadInfo>());
              int progress = uploadInfo.getProgressPercentage();
              expect(progress, uploadProgressStep[callbackCount]);
            },
            complete: (file) {
              expect(event, isA<AmityUploadComplete>());
              expect(file, isA<AmityFile>());
            },
            error: (error) {},
            cancel: () {},
          );
          callbackCount++;
        }, count: uploadProgressStep.length + 1));
  });

  tearDownAll(() async {
    await AmityCoreClient.logout();
  });
}
