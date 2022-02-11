import 'package:amity_sdk/data/data.dart';
import 'package:amity_sdk/domain/domain.dart';
import 'package:amity_sdk/domain/repo/authentication_repo.dart';
import 'package:amity_sdk/domain/usecase/get_all_user_usecase.dart';
import 'package:amity_sdk/domain/usecase/login_usecase.dart';
import 'package:amity_sdk/public/repo/post_repository.dart';
import 'package:amity_sdk/public/repo/user_repository.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance; //sl is referred to as Service Locator

class SdkServiceLocator {
//Dependency injection
  static Future<void> initServiceLocator() async {
    print('>>>>>> Init all the dependenciies');

    ///----------------------------------- Core Layer -----------------------------------///

    ///----------------------------------- Data Layer -----------------------------------///

    //-data_source/remote/
    serviceLocator.registerLazySingleton<HttpApiClient>(
        () => HttpApiClient(amityCoreClientOption: serviceLocator()));

    //-data_source/remote/api_interface
    // sl.registerLazySingleton<PublicPostApiInterface>(
    //     () => PublicPostApiInterfaceImpl(httpApiClient: sl()));
    serviceLocator.registerLazySingleton<AuthenticationApiInterface>(() =>
        AuthenticationApiInterfaceImpl(
            httpApiClient: serviceLocator(),
            amityCoreClientOption: serviceLocator()));
    serviceLocator.registerLazySingleton<UserApiInterface>(
        () => UserApiInterfaceImpl(httpApiClient: serviceLocator()));

    //-data_source/remote/mock_api_interface
    serviceLocator.registerLazySingleton<PublicPostApiInterface>(
        () => MockPublicPostApiInterfaceImpl());

    //-data_source/local/
    serviceLocator
        .registerSingletonAsync<DBClient>(() => HiveDbClient().init());

    //-data_source/local/adapter
    serviceLocator.registerSingletonAsync<AccountDbAdapter>(
        () => AccountDbAdapterImpl(dbClient: serviceLocator()).init(),
        dependsOn: [DBClient]);

    ///----------------------------------- Domain Layer -----------------------------------///

    //-Repo
    serviceLocator.registerLazySingleton<AuthenticationRepo>(() =>
        AuthenticationRepoImpl(
            authenticationApiInterface: serviceLocator(),
            accountDbAdapter: serviceLocator()));
    serviceLocator.registerLazySingleton<PostRepo>(() => PostRepoImpl(
        publicPostApiInterface: serviceLocator(),
        postDbAdapter: serviceLocator()));
    serviceLocator.registerLazySingleton<UserRepo>(
        () => UserRepoImpl(userApiInterface: serviceLocator()));

    //-UserCase
    serviceLocator.registerLazySingleton<GetPostByIdUseCase>(
        () => GetPostByIdUseCase(postRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<LoginUsecase>(
        () => LoginUsecase(authenticationRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<GetAllUserUseCase>(
        () => GetAllUserUseCase(userRepo: serviceLocator()));
    serviceLocator.registerLazySingleton<GetUserByIdUseCase>(
        () => GetUserByIdUseCase(userRepo: serviceLocator()));

    ///----------------------------------- Public Layer -----------------------------------///
    //-public_repo
    serviceLocator.registerLazySingleton(() => PostRepository());
    serviceLocator.registerLazySingleton(() => UserRepository());
  }
}
