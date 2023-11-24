import 'package:amity_sdk/src/core/enum/amity_broadcast_resolution.dart';
import 'package:amity_sdk/src/core/enum/amity_recording_data_format.dart';
import 'package:amity_sdk/src/core/enum/amity_stream_status.dart';
import 'package:amity_sdk/src/core/enum/amity_watcher_data_format.dart';
import 'package:amity_sdk/src/data/response/response.dart';
import 'package:amity_sdk/src/domain/model/amity_user.dart';

class AmityStream {

  String? streamId;

  AmityStreamStatus? status;

  String? title;

  String? description;

  AmityBroadcastResolution? resolution;

  AmityUser? user;

  String? userId;

  DateTime? startedAt;

  DateTime? endedAt;
  
  DateTime? createdAt;
  
  DateTime? updatedAt;

  bool? isDeleted = false;

  bool? isLive = false; 

  WatcherData? watcherData;

  BroadcasterData? broadcasterData;

  String? thumbnailFileId;

  List<AmityRecordingData>? recordings;

}


class BroadcasterData{
  String?  url;
}

class WatcherData{
   Map<String, dynamic> watcherData;

   WatcherData(this.watcherData);

   String getUrl(AmityWatcherDataFormat format){
    return (watcherData[format.name] as ErUrl).url;
   } 
}

class AmityRecordingData{
  Map<String, dynamic> recordingData;

  AmityRecordingData(this.recordingData);

  String getUrl(AmityRecordingDataFormat format){
    print((recordingData[format.name] as Recording).url);
    return (recordingData[format.name] as Recording).url! ;
   } 
}