import 'package:amity_sdk/data/data.dart';
import 'package:amity_sdk/data/data_source/remote/api_interface/commnet_api_interface.dart';
import 'package:amity_sdk/data/data_source/remote/api_interface/reaction_api_interface.dart';
import 'package:amity_sdk/data/data_source/remote/http_api_interface_impl/commant_api_interface_impl.dart';
import 'package:amity_sdk/data/data_source/remote/http_api_interface_impl/reaction_api_interface_impl.dart';
import 'package:amity_sdk/data/repo_impl/reaction_repo_impl.dart';
import 'package:amity_sdk/domain/composer_usecase/user_compose_usecase.dart';
import 'package:amity_sdk/domain/domain.dart';
import 'package:amity_sdk/domain/repo/reaction_repo.dart';
import 'package:amity_sdk/domain/usecase/comment/comment_create_usecase.dart';
import 'package:amity_sdk/domain/usecase/comment/comment_flag_usecase.dart';
import 'package:amity_sdk/domain/usecase/comment/comment_query_usecase.dart';
import 'package:amity_sdk/domain/usecase/comment/comment_unflag_usecase.dart';
import 'package:amity_sdk/domain/usecase/post/post_flag_usecase.dart';
import 'package:amity_sdk/domain/usecase/post/post_unflag_usecase.dart';
import 'package:amity_sdk/domain/usecase/reaction/add_reaction_usecase.dart';
import 'package:amity_sdk/domain/usecase/reaction/remove_reaction_usecase.dart';
import 'package:amity_sdk/public/public.dart';
import 'package:amity_sdk/public/repo/comment_repository.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance; //sl is referred to as Service Locator

class SdkServiceLocator {
//Dependency injection
  static Future<void> initServiceLocator() async {
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

    // Local Data Source
    //-data_source/local/
    serviceLocator
        .registerSingletonAsync<DBClient>(() => HiveDbClient().init());

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

    ///----------------------------------- Domain Layer -----------------------------------///

    //-Repo
    serviceLocator
        .registerLazySingleton<AuthenticationRepo>(() => AuthenticationRepoImpl(
              authenticationApiInterface: serviceLocator(),
              accountDbAdapter: serviceLocator(),
              userDbAdapter: serviceLocator(),
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
    serviceLocator.registerLazySingleton<AccountRepo>(
        () => AccountRepoImpl(accountDbAdapter: serviceLocator()));
    serviceLocator.registerLazySingleton<PostRepo>(() => PostRepoImpl(
          publicPostApiInterface: serviceLocator(),
          postDbAdapter: serviceLocator(),
          commentDbAdapter: serviceLocator(),
          userDbAdapter: serviceLocator(),
          fileDbAdapter: serviceLocator(),
        ));
    serviceLocator.registerLazySingleton<CommentRepo>(() => CommentRepoImpl(
        commentDbAdapter: serviceLocator(),
        commentApiInterface: serviceLocator(),
        fileDbAdapter: serviceLocator(),
        userDbAdapter: serviceLocator(),
        postDbAdapter: serviceLocator()));
    serviceLocator.registerLazySingleton<FileRepo>(
        () => FileRepoImpl(fileDbAdapter: serviceLocator()));
    serviceLocator.registerLazySingleton<ReactionRepo>(
        () => ReactionRepoImpl(reactionApiInterface: serviceLocator()));

    //-UserCase
    serviceLocator.registerLazySingleton<GetPostByIdUseCase>(() =>
        GetPostByIdUseCase(
            postRepo: serviceLocator(), postComposerUsecase: serviceLocator()));
    serviceLocator.registerLazySingleton<LoginUsecase>(
        () => LoginUsecase(authenticationRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<GetAllUserUseCase>(
        () => GetAllUserUseCase(userRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<GetUserByIdUseCase>(
        () => GetUserByIdUseCase(userRepo: serviceLocator()));
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

    serviceLocator
        .registerLazySingleton<AmityFollowRelationshipComposerUsecase>(() =>
            AmityFollowRelationshipComposerUsecase(
                userRepo: serviceLocator(),
                userComposerUsecase: serviceLocator()));

    serviceLocator.registerLazySingleton<GetMyFollowInfoUsecase>(
        () => GetMyFollowInfoUsecase(followRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<GetMyFollowersUsecase>(() =>
        GetMyFollowersUsecase(
            followRepo: serviceLocator(),
            amityFollowRelationshipComposerUsecase: serviceLocator()));
    serviceLocator.registerLazySingleton<GetMyFollowingsUsecase>(() =>
        GetMyFollowingsUsecase(
            followRepo: serviceLocator(),
            amityFollowRelationshipComposerUsecase: serviceLocator()));

    serviceLocator.registerLazySingleton<GetUserFollowInfoUsecase>(
        () => GetUserFollowInfoUsecase(followRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<GetUserFollowersUsecase>(() =>
        GetUserFollowersUsecase(
            followRepo: serviceLocator(),
            amityFollowRelationshipComposerUsecase: serviceLocator()));
    serviceLocator.registerLazySingleton<GetUserFollowingsUsecase>(() =>
        GetUserFollowingsUsecase(
            followRepo: serviceLocator(),
            amityFollowRelationshipComposerUsecase: serviceLocator()));

    serviceLocator.registerLazySingleton<PostComposerUsecase>(() =>
        PostComposerUsecase(
            userRepo: serviceLocator(),
            commentRepo: serviceLocator(),
            postRepo: serviceLocator(),
            userComposerUsecase: serviceLocator(),
            fileRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<PostCreateUsecase>(() =>
        PostCreateUsecase(
            postRepo: serviceLocator(), postComposerUsecase: serviceLocator()));
    serviceLocator.registerLazySingleton<UserComposerUsecase>(
        () => UserComposerUsecase(fileRepo: serviceLocator()));

    serviceLocator.registerLazySingleton<AddReactionUsecase>(
        () => AddReactionUsecase(reactionRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<RemoveReactionUsecase>(
        () => RemoveReactionUsecase(reactionRepo: serviceLocator()));

    serviceLocator.registerLazySingleton<CommentCreateUseCase>(
        () => CommentCreateUseCase(commentRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<CommentQueryUsecase>(
        () => CommentQueryUsecase(commentRepo: serviceLocator()));

    serviceLocator.registerLazySingleton<PostFlagUsecase>(
        () => PostFlagUsecase(postRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<PostUnflagUsecase>(
        () => PostUnflagUsecase(postRepo: serviceLocator()));

    serviceLocator.registerLazySingleton<CommentFlagUsecase>(
        () => CommentFlagUsecase(commentRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<CommentUnflagUsecase>(
        () => CommentUnflagUsecase(commentRepo: serviceLocator()));

    ///----------------------------------- Public Layer -----------------------------------///
    //-public_repo
    serviceLocator.registerLazySingleton(() => PostRepository());
    serviceLocator.registerLazySingleton(() => UserRepository());
    serviceLocator.registerLazySingleton(() => CommentRepository());

    //MQTT Client
    serviceLocator.registerLazySingleton<AmityMQTT>(
      () => AmityMQTT(
          accountRepo: serviceLocator(),
          amityCoreClientOption: serviceLocator()),
    );
  }
}
