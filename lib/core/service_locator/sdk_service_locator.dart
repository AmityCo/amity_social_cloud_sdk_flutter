import 'package:amity_sdk/data/data.dart';
import 'package:amity_sdk/data/data_source/local/db_adapter_repo.dart';
import 'package:amity_sdk/data/data_source/remote/api_interface/notification_api_interface.dart';
import 'package:amity_sdk/data/data_source/remote/http_api_interface_impl/notification_api_interface_impl.dart';
import 'package:amity_sdk/data/repo_impl/notification_repo_impl.dart';
import 'package:amity_sdk/domain/domain.dart';
import 'package:amity_sdk/domain/repo/notification_repo.dart';
import 'package:amity_sdk/domain/usecase/comment/comment_delete_usecase.dart';
import 'package:amity_sdk/domain/usecase/comment/comment_update_usecase.dart';
import 'package:amity_sdk/domain/usecase/post/post_delete_usecase.dart';
import 'package:amity_sdk/public/public.dart';
import 'package:amity_sdk/public/repo/notification_repository.dart';
import 'package:get_it/get_it.dart';

final serviceLocator =
    GetIt.asNewInstance(); //sl is referred to as Service Locator

class SdkServiceLocator {
//Dependency injection
  static Future<void> initServiceLocator({bool syc = false}) async {
    DateTime startTime = DateTime.now();

    print('>>>>>> Init all the dependenciies');

    ///----------------------------------- Core Layer -----------------------------------///

    ///----------------------------------- Data Layer -----------------------------------///

    // Remote Data Source
    //-data_source/remote/
    serviceLocator.registerLazySingleton<HttpApiClient>(
        () => HttpApiClient(amityCoreClientOption: serviceLocator()));

    //-data_source/remote/api_interface
    serviceLocator.registerLazySingleton<PublicPostApiInterface>(
        () => PublicPostApiInterfaceImpl(httpApiClient: serviceLocator()));
    serviceLocator.registerLazySingleton<AuthenticationApiInterface>(() =>
        AuthenticationApiInterfaceImpl(
            httpApiClient: serviceLocator(),
            amityCoreClientOption: serviceLocator()));
    serviceLocator.registerLazySingleton<UserApiInterface>(
        () => UserApiInterfaceImpl(httpApiClient: serviceLocator()));
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
    serviceLocator.registerLazySingleton<NotificationApiInterface>(() =>
        NotificationApiInterfaceImpl(
            httpApiClient: serviceLocator(),
            amityCoreClientOption: serviceLocator()));

    // Local Data Source
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
    serviceLocator.registerSingletonAsync<FeedPagingDbAdapter>(
        () => FeedPagingDbAdapterImpl(dbClient: serviceLocator()).init(),
        dependsOn: [DBClient]);

    //Register Db adapter Repo which hold all the Db Adapters
    serviceLocator.registerLazySingleton<DbAdapterRepo>(() => DbAdapterRepo(
          postDbAdapter: serviceLocator(),
          commentDbAdapter: serviceLocator(),
          communityDbAdapter: serviceLocator(),
          feedDbAdapter: serviceLocator(),
          fileDbAdapter: serviceLocator(),
          userDbAdapter: serviceLocator(),
        ));

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
          userDbAdapter: serviceLocator(),
        ));
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
        postDbAdapter: serviceLocator(),
        commentDbAdapter: serviceLocator(),
        userDbAdapter: serviceLocator(),
        fileDbAdapter: serviceLocator(),
        communityDbAdapter: serviceLocator()));
    serviceLocator.registerLazySingleton<CommentRepo>(() => CommentRepoImpl(
        commentDbAdapter: serviceLocator(),
        commentApiInterface: serviceLocator(),
        fileDbAdapter: serviceLocator(),
        userDbAdapter: serviceLocator(),
        postDbAdapter: serviceLocator()));
    serviceLocator.registerLazySingleton<FileRepo>(() => FileRepoImpl(
        fileDbAdapter: serviceLocator(), fileApiInterface: serviceLocator()));
    serviceLocator.registerLazySingleton<ReactionRepo>(() => ReactionRepoImpl(
        reactionApiInterface: serviceLocator(),
        commentDbAdapter: serviceLocator(),
        postDbAdapter: serviceLocator()));
    serviceLocator.registerLazySingleton<CommunityRepo>(() => CommunityRepoImpl(
        communityApiInterface: serviceLocator(),
        communityDbAdapter: serviceLocator(),
        commentDbAdapter: serviceLocator(),
        userDbAdapter: serviceLocator(),
        fileDbAdapter: serviceLocator()));

    serviceLocator
        .registerLazySingleton<GlobalFeedRepo>(() => GlobalFeedRepoImpl(
              feedApiInterface: serviceLocator(),
              dbAdapterRepo: serviceLocator(),
            ));
    serviceLocator.registerLazySingleton<UserFeedRepo>(() => UserFeedRepoImpl(
          userFeedApiInterface: serviceLocator(),
          postDbAdapter: serviceLocator(),
          commentDbAdapter: serviceLocator(),
          userDbAdapter: serviceLocator(),
          fileDbAdapter: serviceLocator(),
          feedDbAdapter: serviceLocator(),
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

    //-UserCase
    serviceLocator.registerLazySingleton<GetPostByIdUseCase>(() =>
        GetPostByIdUseCase(
            postRepo: serviceLocator(), postComposerUsecase: serviceLocator()));
    serviceLocator.registerLazySingleton<LoginUsecase>(() => LoginUsecase(
        authenticationRepo: serviceLocator(),
        userComposerUsecase: serviceLocator()));
    serviceLocator.registerLazySingleton<GetAllUserUseCase>(() =>
        GetAllUserUseCase(
            userRepo: serviceLocator(), userComposerUsecase: serviceLocator()));
    serviceLocator.registerLazySingleton<GetUserByIdUseCase>(() =>
        GetUserByIdUseCase(
            userRepo: serviceLocator(), userComposerUsecase: serviceLocator()));
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
    serviceLocator.registerLazySingleton<CommentComposerUsecase>(
        () => CommentComposerUsecase(
              commentRepo: serviceLocator(),
              userRepo: serviceLocator(),
              userComposerUsecase: serviceLocator(),
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

    serviceLocator.registerLazySingleton<CommentCreateUseCase>(
        () => CommentCreateUseCase(commentRepo: serviceLocator()));
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

    serviceLocator.registerLazySingleton<GetGlobalFeedUsecase>(
        () => GetGlobalFeedUsecase(serviceLocator(), serviceLocator()));
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

    serviceLocator.registerLazySingleton<CommentDeleteUseCase>(
        () => CommentDeleteUseCase(commentRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<CommentUpdateUsecase>(() =>
        CommentUpdateUsecase(
            commentRepo: serviceLocator(),
            postComposerUsecase: serviceLocator()));

    ///----------------------------------- Public Layer -----------------------------------///
    //-public_repo
    serviceLocator.registerLazySingleton(() => PostRepository());
    serviceLocator.registerLazySingleton(() => UserRepository());
    serviceLocator.registerLazySingleton(() => CommentRepository());
    serviceLocator.registerLazySingleton(() => FeedRepository());
    serviceLocator.registerLazySingleton(() => FileRepository());
    serviceLocator.registerLazySingleton(() => NotificationRepository());

    //MQTT Client
    serviceLocator.registerLazySingleton<AmityMQTT>(
      () => AmityMQTT(
          accountRepo: serviceLocator(),
          amityCoreClientOption: serviceLocator()),
    );

    DateTime endTime = DateTime.now();

    //wait to init all the dependency.
    if (syc) await serviceLocator.allReady();

    print(
        '>> Time took to initilize the DI ${endTime.difference(startTime).inMilliseconds} Milis');
  }
}
