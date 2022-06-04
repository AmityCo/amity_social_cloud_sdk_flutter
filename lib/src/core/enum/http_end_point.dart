// ignore_for_file: constant_identifier_names

import 'package:amity_sdk/src/core/constant/global_constant.dart';

enum AmityRegionalHttpEndpoint { SG, EU, US, STAGING }

extension AmityRegionalHttpEndpointExtension on AmityRegionalHttpEndpoint {
  String get value {
    return [
      SG_HTTP_ENDPOINT,
      EU_HTTP_ENDPOINT,
      US_HTTP_ENDPOINT,
      STAGING_HTTP_ENDPOINT,
    ][index];
  }
}
