// ignore_for_file: constant_identifier_names

import 'package:amity_sdk/src/core/constant/global_constant.dart';

enum AmityRegionalMqttEndpoint { SG, EU, US, STAGING }

extension AmityRegionalMqttEndpointExtension on AmityRegionalMqttEndpoint {
  String get value {
    return [
      SG_MQTT_ENDPOINT,
      EU_MQTT_ENDPOINT,
      US_MQTT_ENDPOINT,
      STAGING_MQTT_ENDPOINT,
    ][index];
  }
}
