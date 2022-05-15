import 'package:amity_sdk/src/core/constant/global_constant.dart';

// ignore: constant_identifier_names
enum AmityRegionalSocketEndpoint { SG, EU, US, STAGING }

extension AmityRegionalSocketEndpointExtension on AmityRegionalSocketEndpoint {
  String get value {
    return [
      SG_SOCKET_ENDPOINT,
      EU_SOCKET_ENDPOINT,
      US_SOCKET_ENDPOINT,
      STAGING_SOCKET_ENDPOINT
    ][index];
  }
}
