import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/model/api_request/stream_query_request.dart';
import 'package:amity_sdk/src/domain/composer_usecase/stream_composer_usecase.dart';
import 'package:amity_sdk/src/domain/model/amity_stream/amity_stream.dart';
import 'package:amity_sdk/src/domain/repo/stream_repo.dart';

class StreamQueryUseCase extends UseCase<
    PageListData<List<AmityStream>, String>, StreamQueryRequest> {
  final StreamRepo streamRepo;
  final StreamComposerUseCase streamComposerUseCase;

  StreamQueryUseCase(
      {required this.streamRepo, required this.streamComposerUseCase});

  @override
  Future<PageListData<List<AmityStream>, String>> get(
      StreamQueryRequest params) async {
    final amityStream = await streamRepo.queryStream(params);
    final amityComposedStream = await Stream.fromIterable(amityStream.data)
        .asyncMap((event) => streamComposerUseCase.get(event))
        .toList();
    return amityStream.withItem1(amityComposedStream);
  }
}
