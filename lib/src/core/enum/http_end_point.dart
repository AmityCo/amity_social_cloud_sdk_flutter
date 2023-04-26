// ignore_for_file: constant_identifier_names

import 'package:amity_sdk/src/core/constant/global_constant.dart';

class AmityRegionalHttpEndpoint {
  final String endpoint;

  static const SG = AmityRegionalHttpEndpoint(SG_HTTP_ENDPOINT);
  static const EU = AmityRegionalHttpEndpoint(EU_HTTP_ENDPOINT);
  static const US = AmityRegionalHttpEndpoint(US_HTTP_ENDPOINT);

  const AmityRegionalHttpEndpoint(this.endpoint);

  factory AmityRegionalHttpEndpoint.custom(String url) => AmityRegionalHttpEndpoint(url);
}
