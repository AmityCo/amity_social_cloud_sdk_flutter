// ignore_for_file: constant_identifier_names

import 'package:amity_sdk/src/core/constant/global_constant.dart';

// enum AmityRegionalSocketEndpoint {
//   SG,
//   EU,
//   US,
// }

// extension AmityRegionalSocketEndpointExtension on AmityRegionalSocketEndpoint {
//   String get value {
//     return [
//       SG_SOCKET_ENDPOINT,
//       EU_SOCKET_ENDPOINT,
//       US_SOCKET_ENDPOINT,
//     ][index];
//   }
// }

class AmityRegionalSocketEndpoint {
  final String endpoint;

  static const SG = AmityRegionalSocketEndpoint(SG_SOCKET_ENDPOINT);
  static const EU = AmityRegionalSocketEndpoint(EU_SOCKET_ENDPOINT);
  static const US = AmityRegionalSocketEndpoint(US_SOCKET_ENDPOINT);

  const AmityRegionalSocketEndpoint(this.endpoint);

  factory AmityRegionalSocketEndpoint.custom(String url) => AmityRegionalSocketEndpoint(url);
}
