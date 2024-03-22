import 'dart:io';

import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/model/api_request/create_stroy_request.dart';
import 'package:amity_sdk/src/core/model/api_request/story_delete_by_id_request.dart';
import 'package:amity_sdk/src/data/converter/story/create_story_response_extension.dart';
import 'package:amity_sdk/src/data/converter/story/story_hive_extension_converter.dart';
import 'package:amity_sdk/src/data/data_source/data_source.dart';
import 'package:amity_sdk/src/data/data_source/remote/api_interface/story_api_interface.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class StoryRepoImpl extends StoryRepo {
  final StoryApiInterface storyApiInterface;
  final DbAdapterRepo dbAdapterRepo;
  final FileRepo fileRepo;

  StoryRepoImpl(
      {required this.storyApiInterface,
      required this.dbAdapterRepo,
      required this.fileRepo});

  @override
  Future<AmityStory> createStory(CreateStoryRequest request) async {
    var entity = request.convertToHiveEntity();
    try {
      final AmityUploadResult<AmityFileInfo> amityUploadResult;
      final fileEntity = FileHiveEntity()
        ..fileId = request.referenceId
        ..filePath = request.uri!.path
        ..createdAt = DateTime.now();
      entity.data?.fileId = request.referenceId;
      dbAdapterRepo.fileDbAdapter.saveFileEntity(fileEntity);

      entity.syncState = AmityStorySyncState.CREATED.value;
      await dbAdapterRepo.storyDbAdapter.saveStoryEntity(entity);

      entity.syncState = AmityStorySyncState.UPLOADING.value;
      await dbAdapterRepo.storyDbAdapter.saveStoryEntity(entity);

      switch (AmityStoryDataTypeExtension.enumOf(request.dataType!)) {
        case AmityStoryDataType.VIDEO:
          amityUploadResult = await fileRepo
              .uploadVidoe(UploadFileRequest(
                  files: [File(request.uri!.path)],
                  feedtype: AmityContentFeedType.STORY.value)
                ..uploadId = request.referenceId
                ..fullImage = true)
              .onError((error, stackTrace) {
            entity.syncState = AmityStorySyncState.FAILED.value;
            return Future.error(error!);
          });
          if (amityUploadResult is AmityUploadComplete) {
            var video =
                (amityUploadResult as AmityUploadComplete).file as AmityVideo;
            request.data?.fileId = video.fileId;
          }

          break;

        case AmityStoryDataType.IMAGE:
          amityUploadResult = await fileRepo
              .uploadImage(UploadFileRequest(files: [File(request.uri!.path)])
                ..uploadId = request.referenceId
                ..fullImage = true).onError((error, stackTrace) {
            entity.syncState = AmityStorySyncState.FAILED.value;
            return Future.error(error!);
          });
          if (amityUploadResult is AmityUploadComplete) {
            var image =
                (amityUploadResult as AmityUploadComplete).file as AmityImage;
            request.data?.fileId = image.fileId;
          }
          break;

        default:
          throw Exception("Invalid data type");
      }

      /// Message Syncing
      entity.syncState = AmityStorySyncState.SYNCING.value;
      dbAdapterRepo.storyDbAdapter.saveStoryEntity(entity);

      final data = await storyApiInterface.createStory(request);
      final amitStory = await data.saveToDb<AmityStory>(dbAdapterRepo);

      return amitStory[0];
    } catch (error) {
      entity.syncState = AmityStorySyncState.FAILED.value;
      dbAdapterRepo.storyDbAdapter.saveStoryEntity(entity);
      rethrow;
    }
  }

  @override
  Future<List<AmityStory>> getStories(GetStoriesByTragetRequest request) async {
    final data = await storyApiInterface.getStories(request);
    // dbAdapterRepo.storyDbAdapter.deleteAllStoryEntity();
    final amitStories = await data.saveToDb<AmityStory>(dbAdapterRepo);
    return amitStories;
  }

  @override
  Stream<List<AmityStory>> listenStories(
      RequestBuilder<GetStoriesByTragetRequest> request) {
    return dbAdapterRepo.storyDbAdapter
        .listenStoryEntities(request)
        .map((event) {
      final req = request.call();
      final List<AmityStory> list = [];
      for (var element in event) {
        list.add(element.convertToAmityStory());
      }

      if (req.options!.orderBy == "desc") {
        list.sort((a, b) => a.createdAt!.compareTo(b.createdAt!) * -1);
      } else {
        list.sort((a, b) => a.createdAt!.compareTo(b.createdAt!) * 1);
      }

      return list;
    });
  }

  @override
  bool hasLocalStory(String storyId) {
    return dbAdapterRepo.storyDbAdapter.getStoryEntity(storyId) != null;
  }

  @override
  Future<bool> deleteStoryById(StoryDeleteByIdRequest params) async {
    final data = await storyApiInterface.deleteStoryById(params);
    dbAdapterRepo.storyDbAdapter.deleteStoryEntity(params.storyId!);
    return data;
  }
}
