import 'package:amity_sdk/src/core/core.dart';

class StoryDataResponse {
    String? text;
    String? fileId;
    String? imageDisplayMode;
    String? thumbnailFileId;
    VideoFileId? videoFileId;

    StoryDataResponse({this.text, this.fileId, this.imageDisplayMode, this.thumbnailFileId, this.videoFileId}); 

    StoryDataResponse.fromJson(Map<String, dynamic> json) {
        text = json['text'];
        fileId = json['fileId'];
        imageDisplayMode = json['imageDisplayMode'];
        thumbnailFileId = json['thumbnailFileId'];
        videoFileId = json['videoFileId'] != null ? VideoFileId?.fromJson(json['videoFileId']) : null;
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['text'] = text;
        data['fileId'] = fileId;
        data['imageDisplayMode'] = imageDisplayMode;
        data['thumbnailFileId'] = thumbnailFileId;
        data['videoFileId'] = videoFileId?.toJson();
        return data..removeNullValue();
    }
}

class VideoFileId {
    String? original;
    String? low;
    String? medium;
    String? high;

    VideoFileId({this.original, this.low, this.medium, this.high}); 

    VideoFileId.fromJson(Map<String, dynamic> json) {
        original = json['original'];
        low = json['low'];
        medium = json['medium'];
        high = json['high'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = Map<String, dynamic>();
        data['original'] = original;
        data['low'] = low;
        data['medium'] = medium;
        data['high'] = high;
        return data;
    }
}