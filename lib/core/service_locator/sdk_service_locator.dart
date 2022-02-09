import 'package:amity_sdk/data/data.dart';
import 'package:amity_sdk/data/data_source/remote/api_interface/authentication_api_interface.dart';
import 'package:amity_sdk/data/data_source/remote/http_api_interface_impl/authentication_api_interface_impl.dart';
import 'package:amity_sdk/data/repo_impl/authentication_repo_impl.dart';
import 'package:amity_sdk/domain/domain.dart';
import 'package:amity_sdk/domain/repo/authentication_repo.dart';
import 'package:amity_sdk/domain/usecase/login_usecase.dart';
import 'package:amity_sdk/public/repo/post_repository.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance; //sl is referred to as Service Locator

class SdkServiceLocator {
//Dependency injection
  static Future<void> initServiceLocator() async {
    print('>>>>>> Init all the dependenciies');

    ///----------------------------------- Core Layer -----------------------------------///

    ///----------------------------------- Data Layer -----------------------------------///

    //-data_source/remote/
    sl.registerLazySingleton<HttpApiClient>(
        () => HttpApiClient(amityCoreClientOption: sl()));

    //-data_source/remote/api_interface
    // sl.registerLazySingleton<PublicPostApiInterface>(
    //     () => PublicPostApiInterfaceImpl(httpApiClient: sl()));
    sl.registerLazySingleton<AuthenticationApiInterface>(() =>
        AuthenticationApiInterfaceImpl(
            httpApiClient: sl(), amityCoreClientOption: sl()));

    //-data_source/remote/mock_api_interface
    sl.registerLazySingleton<PublicPostApiInterface>(
        () => MockPublicPostApiInterfaceImpl());

    //-data_source/local/
    sl.registerLazySingleton<DBClient>(() => HiveDbClient());

    //-data_source/local/adapter
    sl.registerLazySingleton<PostDbAdapter>(
        () => PostDbAdapterImpl(dbClient: sl()));

    ///----------------------------------- Domain Layer -----------------------------------///

    //-Repo
    sl.registerLazySingleton<PostRepo>(
        () => PostRepoImpl(publicPostApiInterface: sl(), postDbAdapter: sl()));
    sl.registerLazySingleton<AuthenticationRepo>(
        () => AuthenticationRepoImpl(authenticationApiInterface: sl()));

    //-UserCase
    sl.registerLazySingleton<GetPostByIdUseCase>(
        () => GetPostByIdUseCase(postRepo: sl()));
    sl.registerLazySingleton<LoginUsecase>(
        () => LoginUsecase(authenticationRepo: sl()));

    ///----------------------------------- Public Layer -----------------------------------///
    //-public_repo
    sl.registerLazySingleton(() => PostRepository());
  }
}
