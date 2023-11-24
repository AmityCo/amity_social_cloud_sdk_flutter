import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/query_builder/stream/stream_get_query_builder.dart';

class StreamRepository{
  
  StreamGetQueryBuilder getStreams(){
    return StreamGetQueryBuilder(serviceLocator<StreamQueryUseCase>());
  }

  Future<AmityStream> getStream(String streamId){
    return serviceLocator<StreamGetUseCase>().get(streamId);
  }


}