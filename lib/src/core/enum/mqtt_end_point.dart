// ignore_for_file: constant_identifier_names

import 'package:amity_sdk/src/core/constant/global_constant.dart';

// enum AmityRegionalMqttEndpoint { SG, EU, US, STAGING }

// extension AmityRegionalMqttEndpointExtension on AmityRegionalMqttEndpoint {
//   String get value {
//     return [
//       SG_MQTT_ENDPOINT,
//       EU_MQTT_ENDPOINT,
//       US_MQTT_ENDPOINT,
//       STAGING_MQTT_ENDPOINT,
//     ][index];
//   }
// }

class AmityRegionalMqttEndpoint {
  final String endpoint;

  static const SG = AmityRegionalMqttEndpoint(SG_HTTP_ENDPOINT);
  static const EU = AmityRegionalMqttEndpoint(EU_HTTP_ENDPOINT);
  static const US = AmityRegionalMqttEndpoint(US_HTTP_ENDPOINT);

  const AmityRegionalMqttEndpoint(this.endpoint);

  factory AmityRegionalMqttEndpoint.custom(String url) => AmityRegionalMqttEndpoint(url);
}
