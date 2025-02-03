export 'access_token_renewal.dart';
abstract class AccessTokenRenewal {
  void renew();
  void renewWithAuthToken(String authToken);
  void unableToRetrieveAuthToken();
}