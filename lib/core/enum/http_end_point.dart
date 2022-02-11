import 'package:amity_sdk/core/constant/global_constant.dart';

// ignore: constant_identifier_names
enum AmityRegionalHttpEndpoint { SG, EU, US, STAGING }

extension AmityRegionalHttpEndpointExtension on AmityRegionalHttpEndpoint {
  String get value {
    return [
      SG_HTTP_ENDPOINT,
      EU_HTTP_ENDPOINT,
      US_HTTP_ENDPOINT,
      STAGING_HTTP_ENDPOINT
    ][index];
  }
}
