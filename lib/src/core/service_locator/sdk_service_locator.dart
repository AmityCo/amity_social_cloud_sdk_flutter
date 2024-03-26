import 'dart:developer';

import 'package:amity_sdk/src/core/socket/amity_socket.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/analytics_db_adapter.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/story_db_adapter.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/story_target_db_adapter.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/tombstone_db_adapter.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_db_adapter_impl/analytics_db_adapter_impl.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_db_adapter_impl/story_db_adapter_impl.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_db_adapter_impl/story_target_db_adapter_impl.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_db_adapter_impl/tombstone_db_adapter_impl.dart';
import 'package:amity_sdk/src/data/data_source/remote/api_interface/analytics_api_interface.dart';
import 'package:amity_sdk/src/data/data_source/remote/api_interface/story_api_interface.dart';
import 'package:amity_sdk/src/data/data_source/remote/http_api_interface_impl/analytics_api_interface_impl.dart';
import 'package:amity_sdk/src/data/data_source/remote/http_api_interface_impl/story_api_interface_impl.dart';
import 'package:amity_sdk/src/data/repo_impl/analytics_repo_impl.dart';
import 'package:amity_sdk/src/data/repo_impl/story_repo_impl.dart';
import 'package:amity_sdk/src/data/repo_impl/tombstone_repo_impl.dart';
import 'package:amity_sdk/src/domain/composer_usecase/story_composer_usercase.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/repo/analytics_repo.dart';
import 'package:amity_sdk/src/domain/repo/tombstone_repo.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/stream_db_adapter.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_db_adapter_impl/stream_db_adapter_impl.dart';
import 'package:amity_sdk/src/data/data_source/remote/api_interface/stream_api_interface.dart';
import 'package:amity_sdk/src/data/data_source/remote/http_api_interface_impl/stream_api_interface_impl.dart';
import 'package:amity_sdk/src/data/repo_impl/stream_repo_impl.dart';
import 'package:amity_sdk/src/domain/composer_usecase/stream_composer_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/community/category/community_get_category_usercase.dart';
import 'package:amity_sdk/src/domain/usecase/community/member/community_member_get_optional_usercase.dart';
import 'package:amity_sdk/src/domain/usecase/feed/get_custom_ranking_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/post/post_observe_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/story/delete_story_by_id_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/story/get_stories_by_target_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/story/story_has_local_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/story/story_observe_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/stream/stream_get_local_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/stream/stream_has_local_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/user/get_reach_user_usecase.dart';
import 'package:amity_sdk/src/functions/stream_function.dart';
import 'package:amity_sdk/src/public/public.dart';
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
    ///
    ///

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
          reactionDbAdapter: serviceLocator(),
          channelDbAdapter: serviceLocator(),
          channelUserDbAdapter: serviceLocator(),
          tombstoneDbAdapter: serviceLocator(),
          streamDbAdapter: serviceLocator(),
          analyticsDbAdapter: serviceLocator(),
          storyDbAdapter: serviceLocator(),
          storyTargetDbAdapter: serviceLocator()),
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
    serviceLocator.registerLazySingleton<UserFeedApiInterface>(
        () => UserFeedApiInterfaceImpl(httpApiClient: serviceLocator()));
    serviceLocator.registerLazySingleton<FileApiInterface>(
        () => FileApiInterfaceImpl(httpApiClient: serviceLocator()));
    serviceLocator.registerLazySingleton<CommunityFeedApiInterface>(
        () => CommunityFeedApiInterfaceImpl(httpApiClient: serviceLocator()));
    serviceLocator.registerLazySingleton<CommunityMemmberApiInterface>(
        () => CommunityMemberApiInterfaceImpl(httpApiClient: serviceLocator()));
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


    // Local Data Source

    ///----------------------------------- Domain Layer -----------------------------------///

    //-Repo
    serviceLocator
        .registerLazySingleton<AuthenticationRepo>(() => AuthenticationRepoImpl(
              authenticationApiInterface: serviceLocator(),
              accountDbAdapter: serviceLocator(),
              userDbAdapter: serviceLocator(),
              fileDbAdapter: serviceLocator(),
            ));
    serviceLocator.registerLazySingleton<UserRepo>(() => UserRepoImpl(
        userApiInterface: serviceLocator(),
        followApiInterface: serviceLocator(),
        userDbAdapter: serviceLocator(),
        fileDbAdapter: serviceLocator(),
        followDbAdapter: serviceLocator(),
        followInfoDbAdapter: serviceLocator()));
    serviceLocator.registerLazySingleton<FollowRepo>(() => FollowRepoImpl(
          followWApiInterface: serviceLocator(),
          followInfoDbAdapter: serviceLocator(),
          followDbAdapter: serviceLocator(),
          userDbAdapter: serviceLocator(),
          fileDbAdapter: serviceLocator(),
        ));
    serviceLocator.registerLazySingleton<AccountRepo>(() => AccountRepoImpl(
          accountDbAdapter: serviceLocator(),
        ));
    serviceLocator.registerLazySingleton<PostRepo>(() => PostRepoImpl(
          publicPostApiInterface: serviceLocator(),
          dbAdapterRepo: serviceLocator(),
        ));
    serviceLocator.registerLazySingleton<CommentRepo>(() => CommentRepoImpl(
        commentApiInterface: serviceLocator(),
        dbAdapterRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<FileRepo>(() => FileRepoImpl(
        fileDbAdapter: serviceLocator(), fileApiInterface: serviceLocator()));
    serviceLocator.registerLazySingleton<ReactionRepo>(() => ReactionRepoImpl(
          reactionApiInterface: serviceLocator(),
          dbAdapterRepo: serviceLocator(),
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
          communityMemberDbAdapter: serviceLocator()),
    );
    serviceLocator.registerLazySingleton<CommunityMemberRepo>(() =>
        CommunityMemberRepoImpl(
            communityMemmberApiInterface: serviceLocator(),
            communityDbAdapter: serviceLocator(),
            communityMemberDbAdapter: serviceLocator(),
            communityMemberPagingDbAdapter: serviceLocator(),
            userDbAdapter: serviceLocator(),
            fileDbAdapter: serviceLocator()));
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
          fileRepo: serviceLocator()),
    );
    serviceLocator.registerLazySingleton<StreamRepo>(
      () => StreamRepoImpl(
        dbAdapterRepo: serviceLocator(),
        streamApiInterface: serviceLocator(),
      ),
    );
    serviceLocator.registerLazySingleton<StoryRepo>(
      () => StoryRepoImpl(
        dbAdapterRepo: serviceLocator(),
        fileRepo: serviceLocator(),
        storyApiInterface: serviceLocator(),
      ),
    );
    serviceLocator.registerLazySingleton<ChannelRepo>(
      () => ChannelRepoImpl(
        commonDbAdapter: serviceLocator(),
        channelApiInterface: serviceLocator(),
      ),
    );
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

    //-UserCase
    serviceLocator.registerLazySingleton<GetPostByIdUseCase>(() =>
        GetPostByIdUseCase(
            postRepo: serviceLocator(), postComposerUsecase: serviceLocator()));
    serviceLocator.registerLazySingleton<LoginUsecase>(() => LoginUsecase(
        authenticationRepo: serviceLocator(),
        userComposerUsecase: serviceLocator(),
        accountDbAdapter: serviceLocator()));
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
            userComposerUsecase: serviceLocator(),
            fileRepo: serviceLocator()));

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
            communityMemberRepo: serviceLocator()));
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

    serviceLocator
        .registerLazySingleton<PostComposerUsecase>(() => PostComposerUsecase(
              userRepo: serviceLocator(),
              commentRepo: serviceLocator(),
              postRepo: serviceLocator(),
              userComposerUsecase: serviceLocator(),
              fileComposerUsecase: serviceLocator(),
              communityRepo: serviceLocator(),
              communityComposerUsecase: serviceLocator(),
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

    serviceLocator.registerLazySingleton<AddReactionUsecase>(
        () => AddReactionUsecase(reactionRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<RemoveReactionUsecase>(
        () => RemoveReactionUsecase(reactionRepo: serviceLocator()));
    serviceLocator
        .registerLazySingleton<GetReactionUsecase>(() => GetReactionUsecase(
              reactionRepo: serviceLocator(),
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
    serviceLocator.registerLazySingleton<CommentQueryUsecase>(() =>
        CommentQueryUsecase(
            commentRepo: serviceLocator(),
            commentComposerUsecase: serviceLocator()));

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
    serviceLocator.registerLazySingleton<PostIsFlaggedByMeUsecase>(
        () => PostIsFlaggedByMeUsecase(postRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<PostHasLocalUsecase>(
        () => PostHasLocalUsecase(postRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<StoryHasLocalUseCase>(
        () => StoryHasLocalUseCase( storyRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<CommentDeleteUseCase>(
        () => CommentDeleteUseCase(commentRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<CommentUpdateUsecase>(() =>
        CommentUpdateUsecase(
            commentRepo: serviceLocator(),
            postComposerUsecase: serviceLocator()));
    serviceLocator.registerLazySingleton<UpdateUserUsecase>(() =>
        UpdateUserUsecase(
            userComposerUsecase: serviceLocator(), userRepo: serviceLocator()));
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

    serviceLocator.registerLazySingleton<PostObserveUseCase>(() =>
        PostObserveUseCase(
            postRepo: serviceLocator(), postComposerUsecase: serviceLocator()));

    serviceLocator.registerLazySingleton<StreamHasLocalUseCase>(
        () => StreamHasLocalUseCase(streamRepo: serviceLocator()));

    serviceLocator.registerLazySingleton<StreamGetLocalUseCase>(
        () => StreamGetLocalUseCase(streamRepo: serviceLocator()));

    serviceLocator.registerLazySingleton<StreamGetUseCase>(() =>
        StreamGetUseCase(
            streamRepo: serviceLocator(),
            streamComposerUseCase: serviceLocator()));

    serviceLocator.registerLazySingleton<ChannelComposerUsecase>(
        () => ChannelComposerUsecase(
              fileRepo: serviceLocator(),
            ));
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
            storyRepo: serviceLocator(),
            storyComposerUseCase: serviceLocator()));
    serviceLocator.registerLazySingleton<StoryObserveUseCase>(() =>
        StoryObserveUseCase(
            storyRepo: serviceLocator(),
            storyComposerUseCase: serviceLocator()));

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
