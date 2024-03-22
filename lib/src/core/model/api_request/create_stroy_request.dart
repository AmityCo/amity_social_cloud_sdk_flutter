import 'dart:io';

import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/story_hive_entity_27.dart';
import 'package:amity_sdk/src/data/response/core_response/story_data_response.dart';

class CreateStoryRequest {
  StoryDataRequest? data;
  String? dataType;
  List<AmityStoryItem?>? items;
  String? targetType;
  String? targetId;
  Map<String, dynamic>? metadata;
  String? referenceId;
  File? uri; 

  CreateStoryRequest(
      {this.data,
      this.dataType,
      this.items,
      this.uri,
      this.targetType,
      this.targetId,
      this.metadata,
      this.referenceId});

  CreateStoryRequest.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? StoryDataRequest?.fromJson(json['data']) : null;
    dataType = json['dataType'];
    if (json['items'] != null) {
      items = <AmityStoryItem>[];
      json['items'].forEach((v) {
        items!.add(AmityStoryItem.fromJson(v));
      });
    }
    targetType = json['targetType'];
    targetId = json['targetId'];
    metadata = json['metadata'];
    referenceId = json['referenceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map  = <String, dynamic>{};
    map['data'] = data!.toJson();
    map['dataType'] = dataType;
    map['items'] = items != null ? items!.map((v) => v?.toJson()).toList() : null;
    map['targetType'] = targetType;
    map['targetId'] = targetId;
    map['metadata'] = metadata;
    map['referenceId'] = referenceId;
    return map..removeNullValue();
  }

  StoryHiveEntity convertToHiveEntity() {
    return StoryHiveEntity(
      data: data?.convertToStoryDataResponse() ,
      dataType: dataType,
      items:  items!.map((e) => e!).toList() ,
      targetType: targetType,
      targetId: targetId,
      metadata: metadata,
      referenceId: referenceId,
      storyId: referenceId,
      creatorPublicId: AmityCoreClient.getUserId(),
      createdAt: DateTime.now().toUtc(),
    );
  }

}

class StoryDataRequest {
  String? text;
  String? fileId;
  String? imageDisplayMode;

  StoryDataRequest({
    this.text,
    this.fileId,
    this.imageDisplayMode,
  });

  StoryDataRequest.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    fileId = json['fileId'];
    imageDisplayMode = json['imageDisplayMode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['fileId'] = fileId;
    data['imageDisplayMode'] = imageDisplayMode;
    return data..removeNullValue();
  }

  StoryDataResponse convertToStoryDataResponse() {
    return StoryDataResponse(
      text: text,
      fileId: fileId,
      imageDisplayMode: imageDisplayMode,
    );
  }
}
