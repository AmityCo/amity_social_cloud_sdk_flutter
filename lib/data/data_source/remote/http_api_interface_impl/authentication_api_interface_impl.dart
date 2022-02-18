import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/data/data.dart';
import 'package:amity_sdk/public/amity_core_client.dart';
import 'package:dio/dio.dart' as dio;

class AuthenticationApiInterfaceImpl extends AuthenticationApiInterface {
  AuthenticationApiInterfaceImpl(
      {required this.httpApiClient, required this.amityCoreClientOption});
  final HttpApiClient httpApiClient;
  final AmityCoreClientOption amityCoreClientOption;
  @override
  Future<SessionResponse> login(AuthenticationRequest request) async {
    try {
      final data = await httpApiClient.dio.post(SESSION_URL,
          data: request,
          options: dio.Options(
              headers: {'X-API-Key': amityCoreClientOption.apiKey}));
      return SessionResponse.fromJson(data.data);
    } on dio.DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }
}
