import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/model/api_request/stream_query_request.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/stream_hive_entity_22.dart';

abstract class StreamDbAdapter{

  /// Save Stream Entity
  Future saveStreamEntity(StreamHiveEntity data);

  /// Delete Stream Entity
  Future deleteStreamEntity(StreamHiveEntity data);

  /// Delete Streams
  void deleteStreams();

  /// get stream entity with stream ID
  StreamHiveEntity? getStreamEntity(String streamId);

  /// Listen stream with stream id
  Stream<StreamHiveEntity> listenStreamEntity(String streamId);

  /// Listen Stream Entities
  Stream<List<StreamHiveEntity>> listenStreamEntities(
      RequestBuilder<StreamQueryRequest> request);


}