import 'package:amity_sdk/src/core/model/api_request/stream_query_request.dart';
import 'package:amity_sdk/src/core/utils/live_collection.dart';
import 'package:amity_sdk/src/core/utils/page_list_data.dart';
import 'package:amity_sdk/src/data/converter/stream/get_stream_response_extension.dart';
import 'package:amity_sdk/src/data/converter/stream/stream_hive_extension_convertor.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/data/data_source/remote/api_interface/stream_api_interface.dart';
import 'package:amity_sdk/src/domain/model/amity_stream/amity_stream.dart';
import 'package:amity_sdk/src/domain/repo/stream_repo.dart';

class StreamRepoImpl extends StreamRepo {
  final StreamApiInterface streamApiInterface;
  final DbAdapterRepo dbAdapterRepo;

  StreamRepoImpl(
      {required this.streamApiInterface, required this.dbAdapterRepo});

  @override
  Stream<List<AmityStream>> listenStreams(
      RequestBuilder<StreamQueryRequest> request) {
    final req = request.call();
    return dbAdapterRepo.streamDbAdapter
        .listenStreamEntities(request)
        .map((event) {
      final List<AmityStream> list = [];
      for (var element in event) {
        list.add(element.convertToAmityStream());
      }
      list.sort((a, b) => a.createdAt!.compareTo(b.createdAt!) * -1);
      return list;
    });
  }

  @override
  Future<PageListData<List<AmityStream>, String>> queryStream(
      StreamQueryRequest request) async {
    final data = await streamApiInterface.getStreams(request);
  
    final isFirstPageRequest = ((request.options?.last ?? 0) > 0) || ((request.options?.before ?? 0) >= 0);
    if (request.options?.token == null ) {
      dbAdapterRepo.streamDbAdapter.deleteStreams();
    }
    final amitStream = await data.saveToDb<AmityStream>(dbAdapterRepo);
    final String token;

    if (request.stackFromEnd == true) {
      token = data.paging!.previous ?? '';
    } else {
      token = data.paging!.next ?? '';
    }
    return PageListData(amitStream, token);
  }

  @override
  Future<AmityStream> getStream(String streamId) async {
    final data = await streamApiInterface.getStream(streamId);
    final amitStream = await data.saveToDb<AmityStream>(dbAdapterRepo);
    return amitStream.first;
  }

  @override
  Future<AmityStream> getStreamFromDb(String streamId) async {
    final stream = dbAdapterRepo.streamDbAdapter
        .getStreamEntity(streamId)!
        .convertToAmityStream();
    return stream;
  }
  
  @override
  AmityStream getLocal(String streamId) {
    return dbAdapterRepo.streamDbAdapter.getStreamEntity(streamId)!.convertToAmityStream();
  }
  
  @override
  bool hasLocal(String streamId) {
    return dbAdapterRepo.streamDbAdapter.getStreamEntity(streamId) !=null ? true : false;
  }
}
