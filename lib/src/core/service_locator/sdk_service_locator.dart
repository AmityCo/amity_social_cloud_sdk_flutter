import 'dart:developer';

import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/socket/amity_socket.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/ad_db_adapter.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/analytics_db_adapter.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/chat_settings_db_adapter.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/message_preview_db_adapter.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/story_db_adapter.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/story_target_db_adapter.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/stream_db_adapter.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/tombstone_db_adapter.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_db_adapter_impl/analytics_db_adapter_impl.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_db_adapter_impl/chat_settings_db_adapter_impl.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_db_adapter_impl/message_preview_db_adapter_impl.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_db_adapter_impl/pin_db_adapter_impl.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_db_adapter_impl/story_db_adapter_impl.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_db_adapter_impl/story_target_db_adapter_impl.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_db_adapter_impl/stream_db_adapter_impl.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_db_adapter_impl/tombstone_db_adapter_impl.dart';
import 'package:amity_sdk/src/data/data_source/remote/api_interface/ad_api_interface.dart';
import 'package:amity_sdk/src/data/data_source/remote/api_interface/channel_notification_api_interface.dart';
import 'package:amity_sdk/src/data/data_source/remote/api_interface/community_notification_api_interface.dart';
import 'package:amity_sdk/src/data/data_source/remote/api_interface/pin_api_interface.dart';
import 'package:amity_sdk/src/data/data_source/remote/api_interface/story_api_interface.dart';
import 'package:amity_sdk/src/data/data_source/remote/api_interface/story_target_api_interface.dart';
import 'package:amity_sdk/src/data/data_source/remote/api_interface/stream_api_interface.dart';
import 'package:amity_sdk/src/data/data_source/remote/api_interface/user_notification_api_interface.dart';
import 'package:amity_sdk/src/data/data_source/remote/http_api_interface_impl/ad_api_interface_impl.dart';
import 'package:amity_sdk/src/data/data_source/remote/http_api_interface_impl/channel_notification_api_interface_impl.dart';
import 'package:amity_sdk/src/data/data_source/remote/http_api_interface_impl/community_notification_api_interface_impl.dart';
import 'package:amity_sdk/src/data/data_source/remote/http_api_interface_impl/pin_api_interface_impl.dart';
import 'package:amity_sdk/src/data/data_source/remote/http_api_interface_impl/stream_api_interface_impl.dart';
import 'package:amity_sdk/src/data/data_source/remote/http_api_interface_impl/user_notification_api_interface_impl.dart';
import 'package:amity_sdk/src/data/repo_impl/ad_repo_impl.dart';
import 'package:amity_sdk/src/data/repo_impl/analytics_repo_impl.dart';
import 'package:amity_sdk/src/data/repo_impl/channel_notification_repo_impl.dart';
import 'package:amity_sdk/src/data/repo_impl/community_notification_repo_impl.dart';
import 'package:amity_sdk/src/data/repo_impl/message_preview_repo_impl.dart';
import 'package:amity_sdk/src/data/repo_impl/network_settings_impl.dart';
import 'package:amity_sdk/src/data/repo_impl/paging_id_repo_impl.dart';
import 'package:amity_sdk/src/data/repo_impl/pin_repo_impl.dart';
import 'package:amity_sdk/src/data/repo_impl/story_repo_impl.dart';
import 'package:amity_sdk/src/data/repo_impl/story_target_repo_impl.dart';
import 'package:amity_sdk/src/data/repo_impl/stream_repo_impl.dart';
import 'package:amity_sdk/src/data/repo_impl/subchannel_repo_impl.dart';
import 'package:amity_sdk/src/data/repo_impl/tombstone_repo_impl.dart';
import 'package:amity_sdk/src/data/repo_impl/user_notification_repo_impl.dart';
import 'package:amity_sdk/src/domain/composer_usecase/advertiser_compose_use_case.dart';
import 'package:amity_sdk/src/domain/composer_usecase/follower_user_composer_usecase.dart';
import 'package:amity_sdk/src/domain/composer_usecase/following_user_composer_usecase.dart';
import 'package:amity_sdk/src/domain/composer_usecase/message_preview_composer_usecase.dart';
import 'package:amity_sdk/src/domain/composer_usecase/network_ads_composer_usecase.dart';
import 'package:amity_sdk/src/domain/composer_usecase/pinned_post_composer_usecase.dart';
import 'package:amity_sdk/src/domain/composer_usecase/reaction_composer_usecase.dart';
import 'package:amity_sdk/src/domain/composer_usecase/story_composer_usercase.dart';
import 'package:amity_sdk/src/domain/composer_usecase/story_target_composer_usecase.dart';
import 'package:amity_sdk/src/domain/composer_usecase/stream_composer_usecase.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/repo/ad_repo.dart';
import 'package:amity_sdk/src/domain/repo/analytics_repo.dart';
import 'package:amity_sdk/src/domain/repo/channel_notification_repo.dart';
import 'package:amity_sdk/src/domain/repo/community_notification_repo.dart';
import 'package:amity_sdk/src/domain/repo/message_preview_repo.dart';
import 'package:amity_sdk/src/domain/repo/network_settings_repo.dart';
import 'package:amity_sdk/src/domain/repo/paging_id_repo.dart';
import 'package:amity_sdk/src/domain/repo/pin_repo.dart';
import 'package:amity_sdk/src/domain/repo/story_target_repo.dart';
import 'package:amity_sdk/src/domain/repo/sub_channel_repo.dart';
import 'package:amity_sdk/src/domain/repo/tombstone_repo.dart';
import 'package:amity_sdk/src/domain/repo/user_notification_repo.dart';
import 'package:amity_sdk/src/domain/usecase/ads/get_advertiser_use_case.dart';
import 'package:amity_sdk/src/domain/usecase/ads/get_network_ads_ucsecase.dart';
import 'package:amity_sdk/src/domain/usecase/channel/channel_fetch_list_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/channel/channel_has_local_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/channel/channel_observe_list_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/channel/channel_observe_new_item_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/channel/channel_update_last_activity_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/channel/member/channel_members_get_cache_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/comment/comment_fetch_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/comment/comment_observe_new_item_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/comment/comment_observe_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/community/category/community_get_category_usercase.dart';
import 'package:amity_sdk/src/domain/usecase/community/community_fetch_list_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/community/community_observe_list_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/community/community_observe_new_item_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/community/community_observe_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/community/member/community_member_fetch_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/community/member/community_member_get_optional_usercase.dart';
import 'package:amity_sdk/src/domain/usecase/community/member/community_member_observe_new_item_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/community/member/community_member_observe_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/feed/custom_ranking_observe_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/feed/custom_ranking_query_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/feed/get_custom_ranking_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/feed/global_feed_observe_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/feed/global_feed_query_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/file/get_image_use_case.dart';
import 'package:amity_sdk/src/domain/usecase/message/message_fetch_use_case.dart';
import 'package:amity_sdk/src/domain/usecase/message/message_observe_list_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/message/message_observe_new_item_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/network/validate_text_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/network/validate_urls_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/paging/paging_id_insert_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/pin/global_pinned_post_observe_query_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/pin/global_pinned_post_query_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/pin/pinned_post_observe_query_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/pin/pinned_post_query_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/post/post_observe_new_item_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/post/post_observe_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/post/post_query_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/reaction/reaction_observe_new_item_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/reaction/reaction_observe_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/reaction/reaction_query_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/relationship/follower_observe_new_item_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/relationship/follower_user_observe_list_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/relationship/following_observe_new_item_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/relationship/following_user_observe_list_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/story/delete_story_by_id_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/story/get_failed_stories_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/story/get_targets_by_targets_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/story/global_story_targets_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/story/story_has_local_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/story/story_target_observe_usercase.dart';
import 'package:amity_sdk/src/domain/usecase/stream/stream_get_local_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/stream/stream_has_local_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/subchannel/sub_channel_create_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/subchannel/sub_channel_delete_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/subchannel/sub_channel_get_by_id_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/subchannel/sub_channel_get_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/subchannel/sub_channel_has_local_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/subchannel/sub_channel_obsever_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/subchannel/sub_channel_update_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/user/get_current_account_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/user/get_reach_user_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/user/user_fetch_list_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/user/user_has_local_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/user/user_observe_list_usecase.dart';
import 'package:amity_sdk/src/functions/stream_function.dart';
import 'package:amity_sdk/src/public/public.dart';
import 'package:amity_sdk/src/public/repo/ads/amity_ad_repository.dart';
import 'package:amity_sdk/src/public/repo/stream/stream_repository.dart';
import 'package:amity_sdk_api/amity_sdk_api.dart';
import 'package:get_it/get_it.dart';

/// Global GetIt instance
final configServiceLocator = GetIt.asNewInstance();

/// Global GetIt instance
final serviceLocator =
    GetIt.asNewInstance(); //sl is referred to as Service Locator

/// Service Locator class to init Get It
class SdkServiceLocator {
  ///Dependency injection
  static Future<void> initServiceLocator({bool syc = false}) async {
    DateTime startTime = DateTime.now();
    serviceLocator.allowReassignment = true;

    ///----------------------------------- Core Layer -----------------------------------///

    ///----------------------------------- Data Layer -----------------------------------///

    // Data Source
    //-data_source/local/
    serviceLocator
        .registerSingletonAsync<DBClient>(() async => HiveDbClient().init());

    //-data_source/local/adapter
    serviceLocator.registerSingletonAsync<AccountDbAdapter>(
        () => AccountDbAdapterImpl(dbClient: serviceLocator()).init(),
        dependsOn: [DBClient]);
    serviceLocator.registerSingletonAsync<UserDbAdapter>(
        () => UserDbAdapterImpl(dbClient: serviceLocator()).init(),
        dependsOn: [DBClient]);
    serviceLocator.registerSingletonAsync<FollowInfoDbAdapter>(
        () => FollowInfoDbAdapterImpl(dbClient: serviceLocator()).init(),
        dependsOn: [DBClient]);
    serviceLocator.registerSingletonAsync<FollowDbAdapter>(
        () => FollowDbAdapterImpl(dbClient: serviceLocator()).init(),
        dependsOn: [DBClient]);
    serviceLocator.registerSingletonAsync<FileDbAdapter>(
        () => FileDbAdapterImpl(dbClient: serviceLocator()).init(),
        dependsOn: [DBClient]);
    serviceLocator.registerSingletonAsync<PostDbAdapter>(
        () => PostDbAdapterImpl(dbClient: serviceLocator()).init(),
        dependsOn: [DBClient]);
    serviceLocator.registerSingletonAsync<CommentDbAdapter>(
        () => CommentDbAdapterImpl(dbClient: serviceLocator()).init(),
        dependsOn: [DBClient]);
    serviceLocator.registerSingletonAsync<CommunityDbAdapter>(
        () => CommunityDbAdapterImpl(dbClient: serviceLocator()).init(),
        dependsOn: [DBClient]);
    serviceLocator.registerSingletonAsync<CommunityCategoryDbAdapter>(
        () => CommunityCategoryDbAdapterImpl(dbClient: serviceLocator()).init(),
        dependsOn: [DBClient]);
    serviceLocator.registerSingletonAsync<CommunityFeedDbAdapter>(
        () => CommunityFeedDbAdapterImpl(dbClient: serviceLocator()).init(),
        dependsOn: [DBClient]);
    serviceLocator.registerSingletonAsync<CommunityMemberDbAdapter>(
        () => CommunityMemberDbAdapterImpl(dbClient: serviceLocator()).init(),
        dependsOn: [DBClient]);
    serviceLocator.registerSingletonAsync<CommunityMemberPagingDbAdapter>(
        () => CommunityMemberPagingDbAdapterImpl(dbClient: serviceLocator())
            .init(),
        dependsOn: [DBClient]);
    serviceLocator.registerSingletonAsync<FeedPagingDbAdapter>(
        () => FeedPagingDbAdapterImpl(dbClient: serviceLocator()).init(),
        dependsOn: [DBClient]);
    serviceLocator.registerSingletonAsync<ReactionDbAdapter>(
        () => ReactionDbAdapterImpl(dbClient: serviceLocator()).init(),
        dependsOn: [DBClient]);
    serviceLocator.registerSingletonAsync<PollDbAdapter>(
        () => PollDbAdapterImpl(dbClient: serviceLocator()).init(),
        dependsOn: [DBClient]);
    serviceLocator.registerSingletonAsync<MessageDbAdapter>(
        () => MessageDbAdapterImpl(dbClient: serviceLocator()).init(),
        dependsOn: [DBClient]);
    serviceLocator.registerSingletonAsync<MessagePreviewDbAdapter>(
        () => MessagePreviewDbAdapterImpl(dbClient: serviceLocator()).init(),
        dependsOn: [DBClient]);
    serviceLocator.registerSingletonAsync<ChannelDbAdapter>(
        () => ChannelDbAdapterImpl(dbClient: serviceLocator()).init(),
        dependsOn: [DBClient]);
    serviceLocator.registerSingletonAsync<ChannelUserDbAdapter>(
        () => ChannelUserDbAdapterImpl(dbClient: serviceLocator()).init(),
        dependsOn: [DBClient]);
    serviceLocator.registerSingletonAsync<TombstoneDbAdapter>(
        () => TombstoneDbAdapterImpl(dbClient: serviceLocator()).init(),
        dependsOn: [DBClient]);
    serviceLocator.registerSingletonAsync<StreamDbAdapter>(
        () => StreamDbAdapterImpl(dbClient: serviceLocator()).init(),
        dependsOn: [DBClient]);
    serviceLocator.registerSingletonAsync<AnalyticsDbAdapter>(
        () => AnalyticsDbAdapterImpl(dbClient: serviceLocator()).init(),
        dependsOn: [DBClient]);
    serviceLocator.registerSingletonAsync<StoryDbAdapter>(
        () => StoryDbAdapterImpl(dbClient: serviceLocator()).init(),
        dependsOn: [DBClient]);
    serviceLocator.registerSingletonAsync<StoryTargetDbAdapter>(
        () => StoryTargetDbAdapterImpl(dbClient: serviceLocator()).init(),
        dependsOn: [DBClient]);
    serviceLocator.registerSingletonAsync<AdDbAdapter>(
        () => AdDbAdapterImpl(dbClient: serviceLocator()).init(),
        dependsOn: [DBClient]);
    serviceLocator.registerSingletonAsync<PagingIdDbAdapter>(
        () => PagingIdDbAdapterImpl(dbClient: serviceLocator()).init(),
        dependsOn: [DBClient]);
    serviceLocator.registerSingletonAsync<PinDbAdapter>(
        () => PinDbAdapterImpl(dbClient: serviceLocator()).init(),
        dependsOn: [DBClient]);
    serviceLocator.registerSingletonAsync<SubChannelDbAdapter>(
        () => SubChannelDbAdapterImpl(dbClient: serviceLocator()).init(),
        dependsOn: [DBClient]);
    serviceLocator.registerSingletonAsync<ChatSettingsDbAdapter>(
        () => ChatSettingsDbAdapterImpl(dbClient: serviceLocator()).init(),
        dependsOn: [DBClient]);

    //Register Db adapter Repo which hold all the Db Adapters
    serviceLocator.registerLazySingleton<DbAdapterRepo>(
      () => DbAdapterRepo(
        postDbAdapter: serviceLocator(),
        commentDbAdapter: serviceLocator(),
        communityDbAdapter: serviceLocator(),
        communityFeedDbAdapter: serviceLocator(),
        communityMemberDbAdapter: serviceLocator(),
        feedDbAdapter: serviceLocator(),
        fileDbAdapter: serviceLocator(),
        userDbAdapter: serviceLocator(),
        communityCategoryDbAdapter: serviceLocator(),
        pollDbAdapter: serviceLocator(),
        messageDbAdapter: serviceLocator(),
        messagePreviewDbAdapter: serviceLocator(),
        reactionDbAdapter: serviceLocator(),
        channelDbAdapter: serviceLocator(),
        channelUserDbAdapter: serviceLocator(),
        tombstoneDbAdapter: serviceLocator(),
        streamDbAdapter: serviceLocator(),
        analyticsDbAdapter: serviceLocator(),
        storyDbAdapter: serviceLocator(),
        storyTargetDbAdapter: serviceLocator(),
        adDbAdapter: serviceLocator(),
        pagingIdDbAdapter: serviceLocator(),
        pinDbAdapter: serviceLocator(),
        subChannelDbAdapter: serviceLocator(),
        chatSettingsDbAdapter: serviceLocator(),
      ),
    );

    //-data_source/remote/
    serviceLocator.registerLazySingleton<HttpApiClient>(
        () => HttpApiClient(amityCoreClientOption: configServiceLocator()));

    //-data_source/remote/api_interface
    serviceLocator.registerLazySingleton<PublicPostApiInterface>(
        () => PublicPostApiInterfaceImpl(httpApiClient: serviceLocator()));
    serviceLocator.registerLazySingleton<AuthenticationApiInterface>(() =>
        AuthenticationApiInterfaceImpl(
            httpApiClient: serviceLocator(),
            amityCoreClientOption: configServiceLocator()));
    serviceLocator.registerLazySingleton<UserApiInterface>(
        () => UserApiInterfaceImpl(httpApiClient: serviceLocator()));
    serviceLocator.registerLazySingleton<UserNotificationApiInterface>(() =>
        UserNotificationApiInterfaceImpl(httpApiClient: serviceLocator()));
    serviceLocator.registerLazySingleton<AnalyticsApiInterface>(
        () => AnalyticsApiInterfaceImpl(httpApiClient: serviceLocator()));
    serviceLocator.registerLazySingleton<FollowApiInterface>(
        () => FollowApiInterfaceImpl(httpApiClient: serviceLocator()));
    serviceLocator.registerLazySingleton<CommentApiInterface>(
        () => CommentApiInterfaceImpl(httpApiClient: serviceLocator()));
    serviceLocator.registerLazySingleton<ReactionApiInterface>(
        () => ReactionApiInterfaceImpl(httpApiClient: serviceLocator()));
    serviceLocator.registerLazySingleton<CommunityApiInterface>(
        () => CommunityApiInterfaceImpl(httpApiClient: serviceLocator()));
    serviceLocator.registerLazySingleton<GlobalFeedApiInterface>(
        () => GlobalFeedApiInterfaceImpl(httpApiClient: serviceLocator()));
    serviceLocator.registerLazySingleton<NetworkSettingsApiInterface>(
        () => NetworkSettingsApiInterfaceImpl(httpApiClient: serviceLocator()));
    serviceLocator.registerLazySingleton<UserFeedApiInterface>(
        () => UserFeedApiInterfaceImpl(httpApiClient: serviceLocator()));
    serviceLocator.registerLazySingleton<FileApiInterface>(
        () => FileApiInterfaceImpl(httpApiClient: serviceLocator()));
    serviceLocator.registerLazySingleton<CommunityFeedApiInterface>(
        () => CommunityFeedApiInterfaceImpl(httpApiClient: serviceLocator()));
    serviceLocator.registerLazySingleton<CommunityMemmberApiInterface>(
        () => CommunityMemberApiInterfaceImpl(httpApiClient: serviceLocator()));
    serviceLocator.registerLazySingleton<CommunityNotificationApiInterface>(
        () => CommunityNotificationApiInterfaceImpl(
            httpApiClient: serviceLocator()));
    serviceLocator.registerLazySingleton<ChannelNotificationApiInterface>(() =>
        ChannelNotificationApiInterfaceImpl(httpApiClient: serviceLocator()));
    serviceLocator.registerLazySingleton<NotificationApiInterface>(() =>
        NotificationApiInterfaceImpl(
            httpApiClient: serviceLocator(),
            amityCoreClientOption: configServiceLocator()));
    serviceLocator.registerLazySingleton<CommunityCategoryApiInterface>(() =>
        CommunityCategoryApiInterfaceImpl(httpApiClient: serviceLocator()));
    serviceLocator.registerLazySingleton<PollApiInterface>(
        () => PollApiInterfaceImpl(httpApiClient: serviceLocator()));
    serviceLocator.registerLazySingleton<MessageApiInterface>(
        () => MessageApiInterfaceImpl(httpApiClient: serviceLocator()));
    serviceLocator.registerLazySingleton<ChannelApiInterface>(
        () => ChannelApiInterfaceImpl(httpApiClient: serviceLocator()));
    serviceLocator.registerLazySingleton<ChannelMemberApiInterface>(
        () => ChannelMemberApiInterfaceImpl(httpApiClient: serviceLocator()));
    serviceLocator.registerLazySingleton<StreamApiInterface>(
        () => StreamApiInterfaceImpl(httpApiClient: serviceLocator()));
    serviceLocator.registerLazySingleton<AnalyticsApiInterface>(
        () => AnalyticsApiInterfaceImpl(httpApiClient: serviceLocator()));
    serviceLocator.registerLazySingleton<StoryApiInterface>(
        () => StoryApiInterfaceImpl(httpApiClient: serviceLocator()));
    serviceLocator.registerLazySingleton<StoryTargetApiInterface>(
        () => StoryTargetApiInterfaceImpl(httpApiClient: serviceLocator()));
    serviceLocator.registerLazySingleton<AdApiInterface>(
        () => AdApiInterfaceImpl(httpApiClient: serviceLocator()));
    serviceLocator.registerLazySingleton<PinApiInterface>(
        () => PinApiInterfaceImpl(httpApiClient: serviceLocator()));
    serviceLocator.registerLazySingleton<SubChannelApiInterface>(
        () => SubChannelApiInterfaceImpl(httpApiClient: serviceLocator()));

    // Local Data Source

    ///----------------------------------- Domain Layer -----------------------------------///

    //-Repo
    serviceLocator
        .registerLazySingleton<AuthenticationRepo>(() => AuthenticationRepoImpl(
              authenticationApiInterface: serviceLocator(),
              accountDbAdapter: serviceLocator(),
              userDbAdapter: serviceLocator(),
              fileDbAdapter: serviceLocator(),
              coreClientOption: configServiceLocator(),
            ));
    serviceLocator.registerLazySingleton<UserRepo>(() => UserRepoImpl(
        userApiInterface: serviceLocator(),
        followApiInterface: serviceLocator(),
        userDbAdapter: serviceLocator(),
        fileDbAdapter: serviceLocator(),
        followDbAdapter: serviceLocator(),
        followInfoDbAdapter: serviceLocator(),
        pagingIdRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<UserNotificationRepo>(() =>
        UserNotificationRepoImpl(
            userNotificationApiInterface: serviceLocator()));
    serviceLocator.registerLazySingleton<FollowRepo>(() => FollowRepoImpl(
          followWApiInterface: serviceLocator(),
          followInfoDbAdapter: serviceLocator(),
          followDbAdapter: serviceLocator(),
          userDbAdapter: serviceLocator(),
          fileDbAdapter: serviceLocator(),
          pagingIdRepo: serviceLocator(),
        ));
    serviceLocator.registerLazySingleton<AccountRepo>(() => AccountRepoImpl(
          accountDbAdapter: serviceLocator(),
        ));
    serviceLocator.registerLazySingleton<PostRepo>(() => PostRepoImpl(
          publicPostApiInterface: serviceLocator(),
          dbAdapterRepo: serviceLocator(),
          pagingIdRepo: serviceLocator(),
        ));
    serviceLocator.registerLazySingleton<CommentRepo>(() => CommentRepoImpl(
        commentApiInterface: serviceLocator(),
        dbAdapterRepo: serviceLocator(),
        pagingIdRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<FileRepo>(() => FileRepoImpl(
        fileDbAdapter: serviceLocator(), fileApiInterface: serviceLocator()));
    serviceLocator.registerLazySingleton<ReactionRepo>(() => ReactionRepoImpl(
          reactionApiInterface: serviceLocator(),
          dbAdapterRepo: serviceLocator(),
          pagingIdRepo: serviceLocator(),
        ));
    serviceLocator.registerLazySingleton<CommunityRepo>(
      () => CommunityRepoImpl(
        communityApiInterface: serviceLocator(),
        communityDbAdapter: serviceLocator(),
        commentDbAdapter: serviceLocator(),
        userDbAdapter: serviceLocator(),
        fileDbAdapter: serviceLocator(),
        communityCategoryDbAdapter: serviceLocator(),
        communityFeedDbAdapter: serviceLocator(),
        communityMemberDbAdapter: serviceLocator(),
        pagingIdRepo: serviceLocator(),
      ),
    );
    serviceLocator.registerLazySingleton<CommunityMemberRepo>(() =>
        CommunityMemberRepoImpl(
            communityMemmberApiInterface: serviceLocator(),
            communityDbAdapter: serviceLocator(),
            communityMemberDbAdapter: serviceLocator(),
            communityMemberPagingDbAdapter: serviceLocator(),
            userDbAdapter: serviceLocator(),
            fileDbAdapter: serviceLocator(),
            pagingIdRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<CommunityNotificationRepo>(() =>
        CommunityNotificationRepoImpl(
            communityNotificationApiInterface: serviceLocator()));
    serviceLocator.registerLazySingleton<CommunityCategoryRepo>(() =>
        CommunityCategoryRepoImpl(
            communityCategoryApiInterface: serviceLocator(),
            communityDbAdapter: serviceLocator(),
            commentDbAdapter: serviceLocator(),
            userDbAdapter: serviceLocator(),
            fileDbAdapter: serviceLocator(),
            communityCategoryDbAdapter: serviceLocator(),
            communityFeedDbAdapter: serviceLocator()));

    serviceLocator
        .registerLazySingleton<GlobalFeedRepo>(() => GlobalFeedRepoImpl(
              pagingIdRepo: serviceLocator(),
              feedApiInterface: serviceLocator(),
              dbAdapterRepo: serviceLocator(),
            ));
    serviceLocator.registerLazySingleton<UserFeedRepo>(() => UserFeedRepoImpl(
          userFeedApiInterface: serviceLocator(),
          dbAdapterRepo: serviceLocator(),
        ));

    serviceLocator
        .registerLazySingleton<CommunityFeedRepo>(() => CommunityFeedRepoImpl(
              communiytFeedApiInterface: serviceLocator(),
              postRepo: serviceLocator(),
              dbAdapterRepo: serviceLocator(),
            ));

    serviceLocator.registerLazySingleton<NotificationRepo>(
      () => NotificationRepoImpl(notificationApiInterface: serviceLocator()),
    );
    serviceLocator.registerLazySingleton<PollRepo>(
      () => PollRepoImpl(
          dbAdapterRepo: serviceLocator(), pollApiInterface: serviceLocator()),
    );
    serviceLocator.registerLazySingleton<MessageRepo>(
      () => MessageRepoImpl(
          dbAdapterRepo: serviceLocator(),
          messageApiInterface: serviceLocator(),
          fileRepo: serviceLocator(),
          channelRepo: serviceLocator(),
          pagingIdRepo: serviceLocator()),
    );
    serviceLocator.registerLazySingleton<MessagePreviewRepo>(
      () => MessagePreviewRepoImpl(
          dbAdapterRepo: serviceLocator()),
    );
    serviceLocator.registerLazySingleton<StreamRepo>(
      () => StreamRepoImpl(
        dbAdapterRepo: serviceLocator(),
        streamApiInterface: serviceLocator(),
      ),
    );
    serviceLocator.registerLazySingleton<NetworkSettingsRepo>(
      () => NetworkSettingsRepoImpl(
        networkSettingsApiInterface: serviceLocator(),
        chatSettingsDbAdapter: serviceLocator(),
      ),
    );
    serviceLocator.registerLazySingleton<StoryRepo>(
      () => StoryRepoImpl(
        dbAdapterRepo: serviceLocator(),
        fileRepo: serviceLocator(),
        storyTargetRepo: serviceLocator(),
        storyApiInterface: serviceLocator(),
      ),
    );
    serviceLocator.registerLazySingleton<StoryTargetRepo>(
      () => StoryTargetRepoImpl(
        dbAdapterRepo: serviceLocator(),
        storyTargetApiInterface: serviceLocator(),
      ),
    );
    serviceLocator.registerLazySingleton<ChannelRepo>(
      () => ChannelRepoImpl(
        commonDbAdapter: serviceLocator(),
        pagingIdRepo: serviceLocator(),
        channelApiInterface: serviceLocator(),
      ),
    );
    serviceLocator.registerLazySingleton<ChannelNotificationRepo>(() =>
        ChannelNotificationRepoImpl(
            channelNotificationApiInterface: serviceLocator()));
    serviceLocator.registerLazySingleton<ChannelMemberRepo>(
      () => ChannelMemberRepoImpl(
        commonDbAdapter: serviceLocator(),
        channelMemberApiInterface: serviceLocator(),
      ),
    );
    serviceLocator.registerLazySingleton<ChannelModerationRepo>(
      () => ChannelModerationRepoImpl(
        commonDbAdapter: serviceLocator(),
        channelMemberApiInterface: serviceLocator(),
      ),
    );

    serviceLocator.registerLazySingleton<TopicRepository>(
      () => TopicRepositoryImpl(amityMqtt: serviceLocator()),
    );

    serviceLocator.registerLazySingleton<TombstoneRepository>(
      () => TombstoneRepoImpl(tombstoneDbAdapter: serviceLocator()),
    );

    serviceLocator.registerLazySingleton<AnalyticsRepo>(
      () => AnalytcisRepoImpl(
          analyticsApiInterface: serviceLocator(),
          dbAdapterRepo: serviceLocator()),
    );

    serviceLocator.registerLazySingleton<AdRepository>(() => AdRepositoryImpl(
          adApiInterface: serviceLocator(),
          dbAdapterRepo: serviceLocator(),
        ));

    serviceLocator.registerLazySingleton<PagingIdRepo>(
      () => PagingIdRepoImpl(commonDbAdapter: serviceLocator()),
    );

    serviceLocator.registerLazySingleton<PinRepo>(
      () => PinRepoImpl(
          pinApiInterface: serviceLocator(), dbAdapterRepo: serviceLocator()),
    );

    serviceLocator.registerLazySingleton<SubChannelRepo>(
      () => SubChannelRepoImpl(
          dbAdapterRepo: serviceLocator(),
          subChannelApiInterface: serviceLocator()),
    );

    //-UserCase
    serviceLocator.registerLazySingleton<PagingIdInsertUsecase>(
        () => PagingIdInsertUsecase(pagingIdDbAdapter: serviceLocator()));
    serviceLocator.registerLazySingleton<GetPostByIdUseCase>(() =>
        GetPostByIdUseCase(
            postRepo: serviceLocator(), postComposerUsecase: serviceLocator()));
    serviceLocator.registerLazySingleton<LoginUsecase>(() => LoginUsecase(
        authenticationRepo: serviceLocator(),
        userComposerUsecase: serviceLocator(),
        accountDbAdapter: serviceLocator()));
    serviceLocator.registerLazySingleton<GetCurrentAccountUseCase>(
        () => GetCurrentAccountUseCase(accountRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<GetUserTokenUsecase>(
        () => GetUserTokenUsecase(authenticationRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<GetAllUserUseCase>(() =>
        GetAllUserUseCase(
            userRepo: serviceLocator(), userComposerUsecase: serviceLocator()));
    serviceLocator.registerLazySingleton<GetUserByIdUseCase>(() =>
        GetUserByIdUseCase(
            userRepo: serviceLocator(), userComposerUsecase: serviceLocator()));
    serviceLocator.registerLazySingleton<GetReachUserUseCase>(() =>
        GetReachUserUseCase(
            analyticsRepo: serviceLocator(),
            userComposerUsecase: serviceLocator()));
    serviceLocator.registerLazySingleton<UserFlagUsecase>(() => UserFlagUsecase(
        userRepo: serviceLocator(), userComposerUsecase: serviceLocator()));
    serviceLocator.registerLazySingleton<UserUnflagUsecase>(() =>
        UserUnflagUsecase(
            userRepo: serviceLocator(), userComposerUsecase: serviceLocator()));
    serviceLocator.registerLazySingleton<UserBlockUsecase>(
        () => UserBlockUsecase(userRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<UserUnblockUsecase>(
        () => UserUnblockUsecase(userRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<GetBlockUserUseCase>(() =>
        GetBlockUserUseCase(
            userRepo: serviceLocator(), userComposerUsecase: serviceLocator()));
    serviceLocator.registerLazySingleton<UserGlobalPermissionCheckUsecase>(
        () => UserGlobalPermissionCheckUsecase(userRepo: serviceLocator()));

    serviceLocator.registerLazySingleton<UserFetchListUseCase>(
      () => UserFetchListUseCase(
        userRepo: serviceLocator(),
      ),
    );
    serviceLocator.registerLazySingleton<UserObserveListUseCase>(() =>
        UserObserveListUseCase(
            userRepo: serviceLocator(),
            pagingIdRepo: serviceLocator(),
            userComposerUsecase: serviceLocator()));

    serviceLocator.registerLazySingleton<FollowingUserObserveListUseCase>(() =>
        FollowingUserObserveListUseCase(
            followRepo: serviceLocator(),
            pagingIdRepo: serviceLocator(),
            userRepo: serviceLocator(),
            followingUserComposerUsecase: serviceLocator()));

    serviceLocator.registerLazySingleton<FollowingObserveNewItemUsecase>(() =>
        FollowingObserveNewItemUsecase(
            userRepo: serviceLocator(),
            followRepo: serviceLocator(),
            pagingIdRepo: serviceLocator()));

    serviceLocator.registerLazySingleton<FollowerUserObserveListUseCase>(() =>
        FollowerUserObserveListUseCase(
            followRepo: serviceLocator(),
            pagingIdRepo: serviceLocator(),
            followerUserComposerUsecase: serviceLocator(),
            userRepo: serviceLocator()));

    serviceLocator.registerLazySingleton<FollowerObserveNewItemUsecase>(() =>
        FollowerObserveNewItemUsecase(
            userRepo: serviceLocator(),
            followRepo: serviceLocator(),
            pagingIdRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<AcceptFollowUsecase>(
        () => AcceptFollowUsecase(followRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<DeclineFollowUsecase>(
        () => DeclineFollowUsecase(followRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<UserFollowRequestUsecase>(
        () => UserFollowRequestUsecase(followRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<UnfollowUsecase>(
        () => UnfollowUsecase(followRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<RemoveFollowerUsecase>(
        () => RemoveFollowerUsecase(followRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<GetFileUserCase>(
        () => GetFileUserCase(serviceLocator()));
    serviceLocator.registerLazySingleton<PostFileComposerUsecase>(
        () => PostFileComposerUsecase(
              fileRepo: serviceLocator(),
            ));
    serviceLocator
        .registerLazySingleton<AmityFollowRelationshipComposerUsecase>(() =>
            AmityFollowRelationshipComposerUsecase(
                userRepo: serviceLocator(),
                userComposerUsecase: serviceLocator()));

    serviceLocator.registerLazySingleton<StoryComposerUseCase>(() =>
        StoryComposerUseCase(
            userRepo: serviceLocator(),
            storyTargetRepo: serviceLocator(),
            storyTargetComposerUseCase: serviceLocator(),
            userComposerUsecase: serviceLocator(),
            fileRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<StoryTargetComposerUseCase>(() =>
        StoryTargetComposerUseCase(
            storyRepo: serviceLocator(),
            storyTargetRepo: serviceLocator(),
            communityComposerUsecase: serviceLocator(),
            communityRepo: serviceLocator()));

    serviceLocator.registerLazySingleton<GetMyFollowInfoUsecase>(
        () => GetMyFollowInfoUsecase(followRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<GetMyFollowersUsecase>(
        () => GetMyFollowersUsecase(
              followRepo: serviceLocator(),
              amityFollowRelationshipComposerUsecase: serviceLocator(),
            ));
    serviceLocator.registerLazySingleton<GetMyFollowingsUsecase>(
        () => GetMyFollowingsUsecase(
              followRepo: serviceLocator(),
              amityFollowRelationshipComposerUsecase: serviceLocator(),
            ));

    serviceLocator.registerLazySingleton<GetUserFollowInfoUsecase>(
        () => GetUserFollowInfoUsecase(
              followRepo: serviceLocator(),
            ));
    serviceLocator.registerLazySingleton<GetUserFollowersUsecase>(
        () => GetUserFollowersUsecase(
              followRepo: serviceLocator(),
              amityFollowRelationshipComposerUsecase: serviceLocator(),
            ));
    serviceLocator.registerLazySingleton<GetUserFollowingsUsecase>(
        () => GetUserFollowingsUsecase(
              followRepo: serviceLocator(),
              amityFollowRelationshipComposerUsecase: serviceLocator(),
            ));

    serviceLocator.registerLazySingleton<CommunityComposerUsecase>(
        () => CommunityComposerUsecase(
              communityRepo: serviceLocator(),
              userRepo: serviceLocator(),
              userComposerUsecase: serviceLocator(),
              fileRepo: serviceLocator(),
            ));
    serviceLocator.registerLazySingleton<CommunityCreateUsecase>(
        () => CommunityCreateUsecase(
              communityRepo: serviceLocator(),
              communityComposerUsecase: serviceLocator(),
            ));
    serviceLocator.registerLazySingleton<CommunityUpdateUseCase>(
        () => CommunityUpdateUseCase(
              communityRepo: serviceLocator(),
              communityComposerUsecase: serviceLocator(),
            ));
    serviceLocator
        .registerLazySingleton<CommunityGetUseCase>(() => CommunityGetUseCase(
              communityRepo: serviceLocator(),
              communityComposerUsecase: serviceLocator(),
            ));
    serviceLocator.registerLazySingleton<CommunityFetchListUseCase>(
        () => CommunityFetchListUseCase(
              communityRepo: serviceLocator(),
            ));
    serviceLocator.registerLazySingleton<CommunityDeleteUseCase>(
        () => CommunityDeleteUseCase(
              communityRepo: serviceLocator(),
            ));
    serviceLocator.registerLazySingleton<CommunityGetQueryUseCase>(
        () => CommunityGetQueryUseCase(
              communityRepo: serviceLocator(),
              communityComposerUsecase: serviceLocator(),
            ));
    serviceLocator.registerLazySingleton<CommunityPostCountUseCase>(
        () => CommunityPostCountUseCase(
              communityRepo: serviceLocator(),
            ));
    serviceLocator.registerLazySingleton<CommunityGetTrendingUseCase>(
        () => CommunityGetTrendingUseCase(
              communityRepo: serviceLocator(),
              communityComposerUsecase: serviceLocator(),
            ));
    serviceLocator.registerLazySingleton<CommunityGetRecommendedUseCase>(
        () => CommunityGetRecommendedUseCase(
              communityRepo: serviceLocator(),
              communityComposerUsecase: serviceLocator(),
            ));
    serviceLocator.registerLazySingleton<CommunityMemberPermissionCheckUsecase>(
        () => CommunityMemberPermissionCheckUsecase(
            communityMemberRepo: serviceLocator(), userRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<CommunityMemberJoinUsecase>(() =>
        CommunityMemberJoinUsecase(communityMemberRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<CommunityMemberLeaveUsecase>(() =>
        CommunityMemberLeaveUsecase(communityMemberRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<CommunityMemberAddRoleUsecase>(() =>
        CommunityMemberAddRoleUsecase(communityMemberRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<CommunityMemberRemoveRoleUsecase>(() =>
        CommunityMemberRemoveRoleUsecase(
            communityMemberRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<CommunityMemberAddUsecase>(() =>
        CommunityMemberAddUsecase(
            communityMemberComposerUsecase: serviceLocator(),
            communityMemberRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<CommunityMemberRemoveUsecase>(() =>
        CommunityMemberRemoveUsecase(communityMemberRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<CommunityMemberBanUsecase>(
        () => CommunityMemberBanUsecase(communityMemberRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<CommunityMemberUnbanUsecase>(() =>
        CommunityMemberUnbanUsecase(communityMemberRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<CommunityMemberQueryUsecase>(() =>
        CommunityMemberQueryUsecase(
            communityMemberRepo: serviceLocator(),
            communityMemberComposerUsecase: serviceLocator()));
    serviceLocator.registerLazySingleton<CommunityMemberComposerUsecase>(() =>
        CommunityMemberComposerUsecase(
            userComposerUsecase: serviceLocator(), userRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<CommunityHasLocalUsecase>(
        () => CommunityHasLocalUsecase(communityRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<CommunityMemberHasLocalUsecase>(() =>
        CommunityMemberHasLocalUsecase(communityMemberRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<CommunityMemberObserveUsecase>(() =>
        CommunityMemberObserveUsecase(
            repo: serviceLocator(),
            userRepo: serviceLocator(),
            usecase: serviceLocator(),
            pagingRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<CommunityMemberFetchListUseCase>(
        () => CommunityMemberFetchListUseCase(
              repo: serviceLocator(),
            ));
    serviceLocator.registerLazySingleton<CommunityMemberObserveNewItemUsecase>(
        () => CommunityMemberObserveNewItemUsecase(
            repo: serviceLocator(),
            pagingIdRepo: serviceLocator(),
            composerUsecase: serviceLocator()));

    serviceLocator.registerLazySingleton<CommunityGetUseCase>(() =>
        CommunityGetUseCase(
            communityRepo: serviceLocator(),
            communityComposerUsecase: serviceLocator()));

    serviceLocator
        .registerLazySingleton<PostComposerUsecase>(() => PostComposerUsecase(
              userRepo: serviceLocator(),
              commentRepo: serviceLocator(),
              postRepo: serviceLocator(),
              userComposerUsecase: serviceLocator(),
              fileComposerUsecase: serviceLocator(),
              communityRepo: serviceLocator(),
              communityMemberRepo: serviceLocator(),
              communityComposerUsecase: serviceLocator(),
              pollRepo: serviceLocator(),
            ));
    serviceLocator.registerLazySingleton<CommentComposerUsecase>(() =>
        CommentComposerUsecase(
            commentRepo: serviceLocator(),
            userRepo: serviceLocator(),
            communityMemberGetOptionalUsecase: serviceLocator(),
            userComposerUsecase: serviceLocator(),
            commentFileComposerUsecase: serviceLocator()));
    serviceLocator.registerLazySingleton<CommentFileComposerUsecase>(
        () => CommentFileComposerUsecase(
              fileRepo: serviceLocator(),
            ));
    serviceLocator
        .registerLazySingleton<PostCreateUsecase>(() => PostCreateUsecase(
              postRepo: serviceLocator(),
              postComposerUsecase: serviceLocator(),
            ));

    serviceLocator
        .registerLazySingleton<UserComposerUsecase>(() => UserComposerUsecase(
              fileRepo: serviceLocator(),
            ));

    serviceLocator.registerLazySingleton<FollowingUserComposerUsecase>(
        () => FollowingUserComposerUsecase(
              followRepo: serviceLocator(),
              userRepo: serviceLocator(),
              userComposerUsecase: serviceLocator(),
            ));

    serviceLocator.registerLazySingleton<FollowerUserComposerUsecase>(
        () => FollowerUserComposerUsecase(
              followRepo: serviceLocator(),
              userRepo: serviceLocator(),
              userComposerUsecase: serviceLocator(),
            ));

    serviceLocator.registerLazySingleton<AddReactionUsecase>(
        () => AddReactionUsecase(reactionRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<RemoveReactionUsecase>(
        () => RemoveReactionUsecase(reactionRepo: serviceLocator()));
    serviceLocator
        .registerLazySingleton<GetReactionUsecase>(() => GetReactionUsecase(
              reactionRepo: serviceLocator(),
              userRepo: serviceLocator(),
            ));
    serviceLocator
        .registerLazySingleton<ReactionQueryUsecase>(() => ReactionQueryUsecase(
              reactionRepo: serviceLocator(),
              userRepo: serviceLocator(),
              reactionComposerUsecase: serviceLocator(),
            ));
    serviceLocator.registerLazySingleton<ReactionComposerUsecase>(
        () => ReactionComposerUsecase(
              reactionRepo: serviceLocator(),
              userComposerUsecase: serviceLocator(),
              userRepo: serviceLocator(),
            ));

    serviceLocator.registerLazySingleton<CommentCreateUseCase>(() =>
        CommentCreateUseCase(
            commentRepo: serviceLocator(),
            commentComposerUsecase: serviceLocator()));
    serviceLocator.registerLazySingleton<CommentGetUseCase>(() =>
        CommentGetUseCase(
            commentRepo: serviceLocator(),
            commentComposerUsecase: serviceLocator()));
    serviceLocator.registerLazySingleton<CommentQueryUseCase>(() =>
        CommentQueryUseCase(
            commentRepo: serviceLocator(),
            commentComposerUsecase: serviceLocator()));
    serviceLocator.registerLazySingleton<CommentFetchUseCase>(
        () => CommentFetchUseCase(commentRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<CommentObserveNewItemUseCase>(() =>
        CommentObserveNewItemUseCase(
            commentRepo: serviceLocator(), pagingIdRepo: serviceLocator()));

    serviceLocator.registerLazySingleton<PostFlagUsecase>(
        () => PostFlagUsecase(postRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<PostUnflagUsecase>(
        () => PostUnflagUsecase(postRepo: serviceLocator()));

    serviceLocator.registerLazySingleton<CommentFlagUsecase>(
        () => CommentFlagUsecase(commentRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<CommentUnflagUsecase>(
        () => CommentUnflagUsecase(commentRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<CommentHasLocalUseCase>(
        () => CommentHasLocalUseCase(commentRepo: serviceLocator()));

    serviceLocator.registerLazySingleton<GetGlobalFeedUsecase>(
        () => GetGlobalFeedUsecase(serviceLocator(), serviceLocator()));
    serviceLocator.registerLazySingleton<GetCustomRankingUseCase>(
        () => GetCustomRankingUseCase(serviceLocator(), serviceLocator()));
    serviceLocator.registerLazySingleton<GetUserFeedUsecase>(
        () => GetUserFeedUsecase(serviceLocator(), serviceLocator()));
    serviceLocator.registerLazySingleton<FileUploadUsecase>(
        () => FileUploadUsecase(serviceLocator()));
    serviceLocator.registerLazySingleton<FileImageUploadUsecase>(
        () => FileImageUploadUsecase(serviceLocator()));
    serviceLocator.registerLazySingleton<FileAudioUploadUsecase>(
        () => FileAudioUploadUsecase(serviceLocator()));
    serviceLocator.registerLazySingleton<FileVideoUploadUsecase>(
        () => FileVideoUploadUsecase(serviceLocator()));
    serviceLocator.registerLazySingleton<GetCommunityFeedUsecase>(
        () => GetCommunityFeedUsecase(serviceLocator(), serviceLocator()));
    serviceLocator.registerLazySingleton<FileUploadCancelUsecase>(
        () => FileUploadCancelUsecase(serviceLocator()));

    serviceLocator.registerLazySingleton<RegisterDeviceNotificationUseCase>(
        () => RegisterDeviceNotificationUseCase(
            notificationRepo: serviceLocator(), accountRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<UnregisterDeviceNotificationUseCase>(
        () => UnregisterDeviceNotificationUseCase(
            notificationRepo: serviceLocator(), accountRepo: serviceLocator()));

    serviceLocator.registerLazySingleton<PostDeleteUseCase>(
        () => PostDeleteUseCase(postRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<PostUpdateUsecase>(() =>
        PostUpdateUsecase(
            postRepo: serviceLocator(), postComposerUsecase: serviceLocator()));
    serviceLocator.registerLazySingleton<PostGetUsecase>(() => PostGetUsecase(
        postRepo: serviceLocator(), postComposerUsecase: serviceLocator()));
    serviceLocator.registerLazySingleton<GlobalStoryTargetsUsecase>(() =>
        GlobalStoryTargetsUsecase(
            storyTargetRepo: serviceLocator(),
            storyTargetComposerUseCase: serviceLocator()));
    serviceLocator.registerLazySingleton<PostIsFlaggedByMeUsecase>(
        () => PostIsFlaggedByMeUsecase(postRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<PostHasLocalUsecase>(
        () => PostHasLocalUsecase(postRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<StoryHasLocalUseCase>(
        () => StoryHasLocalUseCase(storyRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<GetTargetByTargetsUsecase>(
        () => GetTargetByTargetsUsecase(storyTargetRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<CommentDeleteUseCase>(
        () => CommentDeleteUseCase(commentRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<CommentUpdateUsecase>(() =>
        CommentUpdateUsecase(
            commentRepo: serviceLocator(),
            postComposerUsecase: serviceLocator()));
    serviceLocator.registerLazySingleton<UpdateUserUsecase>(() =>
        UpdateUserUsecase(
            userComposerUsecase: serviceLocator(), userRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<UserHasLocalUsecase>(
        () => UserHasLocalUsecase(userRepo: serviceLocator()));

    serviceLocator.registerLazySingleton<CommunityMemberGetUsecase>(
        () => CommunityMemberGetUsecase(communityMemberRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<CommunityMemberGetOptionalUsecase>(
        () => CommunityMemberGetOptionalUsecase(
            communityMemberRepo: serviceLocator()));

    serviceLocator.registerLazySingleton<CommunityCategoryComposerUsecase>(
        () => CommunityCategoryComposerUsecase(fileRepo: serviceLocator()));

    serviceLocator.registerLazySingleton<CommunityCategoryQueryUsecase>(() =>
        CommunityCategoryQueryUsecase(
            communityCategoryRepo: serviceLocator(),
            communityCategoryComposerUsecase: serviceLocator()));

    serviceLocator.registerLazySingleton<CommunityGetCategoryUsecase>(() =>
        CommunityGetCategoryUsecase(
            communityCategoryRepo: serviceLocator(),
            communityCategoryComposerUsecase: serviceLocator()));

    serviceLocator.registerLazySingleton<CommunityObserveListUseCase>(() =>
        CommunityObserveListUseCase(
            communityRepo: serviceLocator(),
            pagingIdRepo: serviceLocator(),
            communityComposerUsecase: serviceLocator()));

    serviceLocator.registerLazySingleton<CommunityObserveNewItemUsecase>(() =>
        CommunityObserveNewItemUsecase(
            communityRepo: serviceLocator(),
            pagingIdRepo: serviceLocator(),
            communityComposerUsecase: serviceLocator()));

    serviceLocator.registerLazySingleton<CommunityObserveUseCase>(() =>
        CommunityObserveUseCase(
            communityRepo: serviceLocator(),
            communityComposerUsecase: serviceLocator()));

    serviceLocator.registerLazySingleton<PostApproveUsecase>(
        () => PostApproveUsecase(postRepo: serviceLocator()));

    serviceLocator.registerLazySingleton<PostDeclineUsecase>(
        () => PostDeclineUsecase(postRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<GetPollUseCase>(
        () => GetPollUseCase(pollRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<CreatePollUseCase>(
        () => CreatePollUseCase(pollRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<PollVoteUseCase>(
        () => PollVoteUseCase(pollRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<DeletePollUseCase>(
        () => DeletePollUseCase(pollRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<ClosePollUseCase>(
        () => ClosePollUseCase(pollRepo: serviceLocator()));

    serviceLocator.registerLazySingleton<MessageComposerUsecase>(() =>
        MessageComposerUsecase(
            userRepo: serviceLocator(),
            messageRepo: serviceLocator(),
            userComposerUsecase: serviceLocator(),
            messageFileComposerUsecase: serviceLocator()));
    serviceLocator.registerLazySingleton<StreamComposerUseCase>(() =>
        StreamComposerUseCase(
            userRepo: serviceLocator(), userComposerUsecase: serviceLocator()));
    serviceLocator.registerLazySingleton<MessageFileComposerUsecase>(
        () => MessageFileComposerUsecase(fileRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<MessageQueryUseCase>(() =>
        MessageQueryUseCase(
            messageRepo: serviceLocator(),
            messageComposerUsecase: serviceLocator()));
    serviceLocator.registerLazySingleton<MessageFetchUseCase>(
        () => MessageFetchUseCase(messageRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<MessageObserveListUseCase>(() =>
        MessageObserveListUseCase(
            messageRepo: serviceLocator(),
            pagingIdRepo: serviceLocator(),
            messageComposerUsecase: serviceLocator()));
    serviceLocator.registerLazySingleton<MessageObserveNewItemUseCase>(() =>
        MessageObserveNewItemUseCase(
            messageRepo: serviceLocator(), pagingIdRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<StreamQueryUseCase>(() =>
        StreamQueryUseCase(
            streamRepo: serviceLocator(),
            streamComposerUseCase: serviceLocator()));
    serviceLocator.registerLazySingleton<MessageCreateUsecase>(() =>
        MessageCreateUsecase(
            messageRepo: serviceLocator(),
            messageComposerUsecase: serviceLocator()));
    serviceLocator.registerLazySingleton<MessageUpdateUsecase>(() =>
        MessageUpdateUsecase(
            messageRepo: serviceLocator(),
            messageComposerUsecase: serviceLocator()));
    serviceLocator.registerLazySingleton<MessageDeleteUsecase>(
        () => MessageDeleteUsecase(messageRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<MessageCreateFileUsecase>(() =>
        MessageCreateFileUsecase(
            messageRepo: serviceLocator(),
            messageComposerUsecase: serviceLocator()));
    serviceLocator.registerLazySingleton<MessageHasLocalUsecase>(
        () => MessageHasLocalUsecase(messageRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<MessageGetLocalUsecase>(
        () => MessageGetLocalUsecase(messageRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<MessageGetUseCase>(() =>
        MessageGetUseCase(
            messageRepo: serviceLocator(),
            messageComposerUsecase: serviceLocator()));
    serviceLocator.registerLazySingleton<MessageFlagUsecase>(
        () => MessageFlagUsecase(messageRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<ValidateTextsUseCase>(
        () => ValidateTextsUseCase(networkSettingsRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<ValidateUrlsUseCase>(
        () => ValidateUrlsUseCase(networkSettingsRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<MessageUnflagUsecase>(
        () => MessageUnflagUsecase(messageRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<MessageObserveUsecase>(() =>
        MessageObserveUsecase(
            messageRepo: serviceLocator(),
            messageComposerUsecase: serviceLocator()));
    serviceLocator.registerLazySingleton<StreamObserveUseCase>(() =>
        StreamObserveUseCase(
            streamRepo: serviceLocator(),
            streamComposerUseCase: serviceLocator()));
    serviceLocator
        .registerLazySingleton<PostObserveUseCase>(() => PostObserveUseCase(
              postRepo: serviceLocator(),
              pagingIdRepo: serviceLocator(),
              postComposerUsecase: serviceLocator(),
            ));
    serviceLocator
        .registerLazySingleton<PostObserveNewItemUsecase>(() => PostObserveNewItemUsecase(
              postRepo: serviceLocator(),
              pagingIdRepo: serviceLocator(),
            ));        
    serviceLocator.registerLazySingleton<CommentObserveUseCase>(() =>
        CommentObserveUseCase(
            commentRepo: serviceLocator(),
            commentComposerUsecase: serviceLocator()));
    serviceLocator.registerLazySingleton<ReactionObserveUseCase>(
        () => ReactionObserveUseCase(
              reactionRepo: serviceLocator(),
              reactionComposerUsecase: serviceLocator(),
              pagingIdRepo: serviceLocator(),
            ));
    serviceLocator.registerLazySingleton<ReactionObserveNewItemUseCase>(() =>
        ReactionObserveNewItemUseCase(
            reactionRepo: serviceLocator(), pagingIdRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<StreamHasLocalUseCase>(
        () => StreamHasLocalUseCase(streamRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<StreamGetLocalUseCase>(
        () => StreamGetLocalUseCase(streamRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<StreamGetUseCase>(() =>
        StreamGetUseCase(
            streamRepo: serviceLocator(),
            streamComposerUseCase: serviceLocator()));
    serviceLocator.registerLazySingleton<MessagePreviewComposerUsecase>(() =>
        MessagePreviewComposerUsecase(
            userRepo: serviceLocator(),
            userComposerUsecase: serviceLocator()));
    serviceLocator.registerLazySingleton<ChannelComposerUsecase>(
        () => ChannelComposerUsecase(
              fileRepo: serviceLocator(),
              messagePreviewRepo: serviceLocator(),
              messagePreviewComposerUsecase: serviceLocator(),
            ));
    serviceLocator.registerLazySingleton<ChannelHasLocalUsecase>(
        () => ChannelHasLocalUsecase(channelRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<ChannelMemberComposerUsecase>(
        () => ChannelMemberComposerUsecase(
              channelRepo: serviceLocator(),
              userRepo: serviceLocator(),
              userComposerUsecase: serviceLocator(),
            ));
    serviceLocator
        .registerLazySingleton<ChannelGetUseCase>(() => ChannelGetUseCase(
              channelRepo: serviceLocator(),
              channelComposerUsecase: serviceLocator(),
            ));
    serviceLocator.registerLazySingleton<ChannelGetQueryUseCase>(
        () => ChannelGetQueryUseCase(
              channelRepo: serviceLocator(),
              channelComposerUsecase: serviceLocator(),
            ));
    serviceLocator.registerLazySingleton<ChannelMemberJoinUsecase>(
        () => ChannelMemberJoinUsecase(
              channelMemberRepo: serviceLocator(),
              channelComposerUsecase: serviceLocator(),
            ));
    serviceLocator.registerLazySingleton<ChannelMemberLeaveUsecase>(
        () => ChannelMemberLeaveUsecase(
              channelMemberRepo: serviceLocator(),
            ));
    serviceLocator.registerLazySingleton<ChannelMemberGetUsecase>(() =>
        ChannelMemberGetUsecase(
            channelMemberRepo: serviceLocator(),
            channelMemberComposerUsecase: serviceLocator()));
    serviceLocator.registerLazySingleton<ChannelGetMembersFromCacheUsecase>(
        () => ChannelGetMembersFromCacheUsecase(
            channelMemberRepo: serviceLocator(),
            channelMemberComposerUsecase: serviceLocator()));
    serviceLocator.registerLazySingleton<ChannelMemberQueryUsecase>(() =>
        ChannelMemberQueryUsecase(
            channelMemberRepo: serviceLocator(),
            channelMemberComposerUsecase: serviceLocator()));
    serviceLocator.registerLazySingleton<ChannelMemberSearchUsecase>(() =>
        ChannelMemberSearchUsecase(
            channelMemberRepo: serviceLocator(),
            channelMemberComposerUsecase: serviceLocator()));
    serviceLocator.registerLazySingleton<ChannelMemberAddRoleUsecase>(() =>
        ChannelMemberAddRoleUsecase(channelModerationRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<ChannelMemberRemoveRoleUsecase>(() =>
        ChannelMemberRemoveRoleUsecase(
            channelModerationRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<ChannelMemberAddUsecase>(() =>
        ChannelMemberAddUsecase(
            channelMemberRepo: serviceLocator(),
            channelMemberComposerUsecase: serviceLocator()));
    serviceLocator.registerLazySingleton<ChannelMemberRemoveUsecase>(
        () => ChannelMemberRemoveUsecase(channelMemberRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<ChannelMemberBanUsecase>(
        () => ChannelMemberBanUsecase(channelMemberRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<ChannelMemberUnbanUsecase>(
        () => ChannelMemberUnbanUsecase(channelMemberRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<ChannelMemberPermissionCheckUsecase>(
        () => ChannelMemberPermissionCheckUsecase(
            channelMemberRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<ChannelMuteUsecase>(
        () => ChannelMuteUsecase(channelRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<ChannelMemberMuteUsecase>(
        () => ChannelMemberMuteUsecase(channelMemberRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<ChannelCreateUsecase>(() =>
        ChannelCreateUsecase(
            channelRepo: serviceLocator(),
            channelComposerUsecase: serviceLocator()));
    serviceLocator.registerLazySingleton<ChannelUpdateUseCase>(() =>
        ChannelUpdateUseCase(
            channelRepo: serviceLocator(),
            channelComposerUsecase: serviceLocator()));
    serviceLocator.registerLazySingleton<ChannelObserveNewItemUseCase>(() =>
        ChannelObserveNewItemUseCase(
            channelRepo: serviceLocator(), pagingIdRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<TopicSubscriptionUseCase>(
        () => TopicSubscriptionUseCase(topicRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<TopicUnsubscriptionUseCase>(
        () => TopicUnsubscriptionUseCase(topicRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<GetStoryByTargetUseCase>(() =>
        GetStoryByTargetUseCase(
            storyRepo: serviceLocator(),
            storyComposerUseCase: serviceLocator()));
    serviceLocator.registerLazySingleton<DeleteStroyByIdUsecas>(() =>
        DeleteStroyByIdUsecas(
            storyRepoTraget: serviceLocator(),
            storyRepo: serviceLocator(),
            storyComposerUseCase: serviceLocator()));
    serviceLocator.registerLazySingleton<GetFailedStoriesUseCase>(() =>
        GetFailedStoriesUseCase(
            storyRepo: serviceLocator(),
            storyComposerUseCase: serviceLocator()));
    serviceLocator.registerLazySingleton<StoryObserveUseCase>(() =>
        StoryObserveUseCase(
            storyRepo: serviceLocator(),
            getFailedStoriesUseCase: serviceLocator(),
            storyComposerUseCase: serviceLocator()));
    serviceLocator.registerLazySingleton<StoryTargetObserveUsecase>(() =>
        StoryTargetObserveUsecase(
            storyTargetRepo: serviceLocator(),
            storyTargetComposerUseCase: serviceLocator()));
    serviceLocator.registerLazySingleton<ChannelObserveListUseCase>(
      () => ChannelObserveListUseCase(
        channelRepo: serviceLocator(),
        pagingIdRepo: serviceLocator(),
        channelComposerUsecase: serviceLocator(),
        messagePreviewRepo: serviceLocator(),
      ),
    );
    serviceLocator.registerLazySingleton<ChannelFetchListUseCase>(
      () => ChannelFetchListUseCase(
        channelRepo: serviceLocator(),
      ),
    );
    serviceLocator.registerLazySingleton<ChannelUpdateLastActivityUsecase>(
      () => ChannelUpdateLastActivityUsecase(
        channelRepo: serviceLocator(),
      ),
    );
    serviceLocator.registerLazySingleton<PinnedPostComposerUsecase>(
      () => PinnedPostComposerUsecase(
        pinRepo: serviceLocator(),
        postRepo: serviceLocator(),
        userRepo: serviceLocator(),
        postComposerUsecase: serviceLocator(),
        userComposerUsecase: serviceLocator(),
      ),
    );
    serviceLocator.registerLazySingleton<PinnedPostQueryUseCase>(
      () => PinnedPostQueryUseCase(
        pinRepo: serviceLocator(),
      ),
    );
    serviceLocator.registerLazySingleton<GlobalPinnedPostQueryUseCase>(
      () => GlobalPinnedPostQueryUseCase(
        pinRepo: serviceLocator(),
      ),
    );
    serviceLocator.registerLazySingleton<PinnedPostObserveQueryUseCase>(
      () => PinnedPostObserveQueryUseCase(
        pinRepo: serviceLocator(),
        postRepo: serviceLocator(),
        pagingIdRepo: serviceLocator(),
        pinnedPostComposerUsecase: serviceLocator(),
      ),
    );
    serviceLocator.registerLazySingleton<GlobalPinnedPostObserveQueryUseCase>(
      () => GlobalPinnedPostObserveQueryUseCase(
        pinRepo: serviceLocator(),
        postRepo: serviceLocator(),
        pagingIdRepo: serviceLocator(),
        pinnedPostComposerUsecase: serviceLocator(),
      ),
    );
    serviceLocator.registerLazySingleton<PostQueryUsecase>(
      () => PostQueryUsecase(
        postRepo: serviceLocator(),
        postComposerUsecase: serviceLocator(),
      ),
    );
    serviceLocator.registerLazySingleton<GlobalFeedQueryUsecase>(
      () => GlobalFeedQueryUsecase(
        globalFeedRepo: serviceLocator(),
        postRepo: serviceLocator(),
        postComposerUsecase: serviceLocator(),
      ),
    );
    serviceLocator.registerLazySingleton<GlobalFeedObserveUseCase>(
      () => GlobalFeedObserveUseCase(
        globalFeedRepo: serviceLocator(),
        postRepo: serviceLocator(),
        postComposerUsecase: serviceLocator(),
        pagingIdRepo: serviceLocator(),
      ),
    );
    serviceLocator.registerLazySingleton<CustomRankingQueryUsecase>(
      () => CustomRankingQueryUsecase(
        globalFeedRepo: serviceLocator(),
        postRepo: serviceLocator(),
        postComposerUsecase: serviceLocator(),
      ),
    );
    serviceLocator.registerLazySingleton<CustomRankingObserveUseCase>(
      () => CustomRankingObserveUseCase(
        globalFeedRepo: serviceLocator(),
        postRepo: serviceLocator(),
        postComposerUsecase: serviceLocator(),
        pagingIdRepo: serviceLocator(),
      ),
    );

    serviceLocator.registerLazySingleton<GetImageUseCase>(
        () => GetImageUseCase(fileRepo: serviceLocator()));

    serviceLocator.registerLazySingleton<AdvertiserComposerUseCase>(
        () => AdvertiserComposerUseCase(fileRepo: serviceLocator()));

    serviceLocator.registerLazySingleton<GetAdvertiserUseCase>(
        () => GetAdvertiserUseCase(adRepo: serviceLocator()));

    serviceLocator.registerLazySingleton<NetworkAdsComposerUseCase>(
        () => NetworkAdsComposerUseCase(fileRepo: serviceLocator()));

    serviceLocator.registerLazySingleton<GetNetworkAdsUseCase>(
        () => GetNetworkAdsUseCase(adRepo: serviceLocator()));

    serviceLocator.registerLazySingleton<SubChannelCreateUseCase>(
        () => SubChannelCreateUseCase(subChannelRepo: serviceLocator()));

    serviceLocator.registerLazySingleton<SubChannelGetUsecase>(
        () => SubChannelGetUsecase(subChannelRepo: serviceLocator()));

    serviceLocator.registerLazySingleton<SubChannelGetByIdUsecase>(
        () => SubChannelGetByIdUsecase(subChannelRepo: serviceLocator()));

    serviceLocator.registerLazySingleton<SubChannelDeleteUseCase>(
        () => SubChannelDeleteUseCase(subChannelRepo: serviceLocator()));

    serviceLocator.registerLazySingleton<SubChannelUpdateUseCase>(
        () => SubChannelUpdateUseCase(subChannelRepo: serviceLocator()));

    serviceLocator.registerLazySingleton<SubChannelHasLocalUseCase>(
        () => SubChannelHasLocalUseCase(subChannelRepo: serviceLocator()));

    serviceLocator.registerLazySingleton<SubChannelObserverUseCase>(
        () => SubChannelObserverUseCase(subChannelRepo: serviceLocator()));

    //-data_source/remote/
    serviceLocator
        .registerLazySingleton<StreamFunctionInterface>(() => StreamFunction());

    ///----------------------------------- Public Layer -----------------------------------///
    //-public_repo
    serviceLocator.registerLazySingleton(() => PostRepository());
    serviceLocator.registerLazySingleton(() => UserRepository());
    serviceLocator.registerLazySingleton(() => CommentRepository());
    serviceLocator.registerLazySingleton(() => FeedRepository());
    serviceLocator.registerLazySingleton(() => AmityFileRepository());
    serviceLocator.registerLazySingleton(() => NotificationRepository());
    serviceLocator.registerLazySingleton(() => AmityCommunityRepository());
    serviceLocator.registerLazySingleton(() => PollRepository());
    serviceLocator.registerLazySingleton(() => MessageRepository());
    serviceLocator.registerLazySingleton(() => AmityChannelRepository());
    serviceLocator.registerLazySingleton(() => AmityChannelParticipation());
    serviceLocator.registerLazySingleton(() => ChannelModerationRepository());
    serviceLocator.registerLazySingleton(() => StreamRepository());
    serviceLocator.registerLazySingleton(() => AmityStoryRepository());
    serviceLocator.registerLazySingleton(() => AmityReactionRepository());
    serviceLocator.registerLazySingleton(() => AmityAdRepository());
    serviceLocator.registerLazySingleton(() => AmitySubChannelRepository());

    //MQTT Client
    serviceLocator.registerLazySingleton<AmityMQTT>(
      () => AmityMQTT(
          accountRepo: serviceLocator(),
          amityCoreClientOption: configServiceLocator()),
    );

    //socket client
    serviceLocator.registerLazySingleton<AmitySocket>(
      () => AmitySocket(
          accountRepo: serviceLocator(),
          amityCoreClientOption: configServiceLocator()),
    );

    DateTime endTime = DateTime.now();

    //wait to init all the dependency.
    if (syc) await serviceLocator.allReady();

    log('>> Time took to initilize the DI ${endTime.difference(startTime).inMilliseconds} Milis');
  }

  /// Refresh the service locator
  static Future reloadServiceLocator() async {
    await serviceLocator.reset(dispose: true);
    await initServiceLocator(syc: true);
  }
}
