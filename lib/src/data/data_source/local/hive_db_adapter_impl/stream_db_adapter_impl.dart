import 'package:amity_sdk/src/core/model/api_request/stream_query_request.dart';
import 'package:amity_sdk/src/core/utils/live_collection.dart';
import 'package:amity_sdk/src/data/converter/stream/stream_hive_extension_convertor.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/stream_db_adapter.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/stream_hive_entity_22.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StreamDbAdapterImpl extends StreamDbAdapter{


  StreamDbAdapterImpl({required this.dbClient});

  /// Db Client
  final DBClient dbClient;

  /// Message Box
  late Box<StreamHiveEntity> box;

  /// Init [StreamDbAdapterImpl]
  Future<StreamDbAdapter> init() async {
    Hive.registerAdapter(StreamHiveEntityAdapter(), override: true);
    box = await Hive.openBox<StreamHiveEntity>('Stream_db');
    return this;
  }
  
  @override
  Future deleteStreamEntity(StreamHiveEntity data) async {
    await box.delete(data.streamId);
  }
  
  @override
  StreamHiveEntity? getStreamEntity(String streamId)  {
    return box.get(streamId);
  }
  
  @override
  Stream<List<StreamHiveEntity>> listenStreamEntities(RequestBuilder<StreamQueryRequest> request) {
    return box.watch().map((event) => box.values
        .where((stream) => stream.isMatchingFilter(request.call())
            //missing tags
            )
        .toList());
  }
  
  @override
  Stream<StreamHiveEntity> listenStreamEntity(String streamId)  {
    return box.watch(key: streamId).map((event) => event.value);
  }
  
  @override
  Future saveStreamEntity(StreamHiveEntity data) async {
    await box.put(data.streamId, data);
  }
  
  @override
  void deleteStreams() {
    for (var element in box.values) {
      element.delete();
    }
  }

  
  


}