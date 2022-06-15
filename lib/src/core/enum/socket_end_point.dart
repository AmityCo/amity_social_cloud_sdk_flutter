// ignore_for_file: constant_identifier_names

import 'package:amity_sdk/src/core/constant/global_constant.dart';

enum AmityRegionalSocketEndpoint {
  SG,
  EU,
  US,
}

extension AmityRegionalSocketEndpointExtension on AmityRegionalSocketEndpoint {
  String get value {
    return [
      SG_SOCKET_ENDPOINT,
      EU_SOCKET_ENDPOINT,
      US_SOCKET_ENDPOINT,
    ][index];
  }
}
