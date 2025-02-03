import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/public/amity_core_client.dart';
import 'package:dio/dio.dart' as dio;

class AuthenticationApiInterfaceImpl extends AuthenticationApiInterface {
  AuthenticationApiInterfaceImpl(
      {required this.httpApiClient, required this.amityCoreClientOption});
  final HttpApiClient httpApiClient;
  final AmityCoreClientOption amityCoreClientOption;
  @override
  Future<SessionResponse> login(
    AuthenticationRequest request,
    { bool isLegacyVersion = true }
  ) async {
    try {
      final url = isLegacyVersion ? SESSION_URL_LEGACY : SESSION_URL;
      final data = await httpApiClient().post(url,
          data: request,
          options: dio.Options(
              headers: {'X-API-Key': amityCoreClientOption.apiKey}));
      return SessionResponse.fromJson(data.data);
    } on dio.DioException catch (error) {
      final errorResponse = error.response;
      final amityError = (errorResponse != null) 
        ? AmityErrorResponse.fromJson(errorResponse.data).amityException()
        : error.toAmityExcetion();
      return Future.error(amityError);
    }
  }

  @override
  Future<SessionResponse> refreshToken(
      String userId, String refreshToken) async {
    try {
      final data = await httpApiClient().get(
        REFRESH_TOKEN,
        queryParameters: {'userId': userId, 'refreshToken': refreshToken},
      );
      return SessionResponse.fromJson(data.data);
    } on dio.DioException catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future verifyAccessToken() async {
    try {
      await httpApiClient().get(SESSION_URL_LEGACY,
          options: dio.Options(
              headers: {'X-API-Key': amityCoreClientOption.apiKey}));
    } on dio.DioException catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }
}
