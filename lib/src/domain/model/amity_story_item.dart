import 'package:amity_sdk/src/core/core.dart';

sealed class AmityStoryItem {
  String itemType;
  AmityStoryItem(this.itemType);

  Map<String, dynamic> toJson() => {
        "type": itemType,
        "data": getData(),
      }..removeNullValue();

  factory AmityStoryItem.fromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case "hyperlink":
        return HyperLink.fromJson(json["data"])..itemType = "hyperlink";
    }

    // Remove with null
    return HyperLink.fromJson(json)..itemType = "hyperlink";
  }

  Map<String, dynamic> getData();
}

class HyperLink extends AmityStoryItem {
  String? url;
  String? customText;

  HyperLink({this.url, this.customText}) : super("hyperlink");

  factory HyperLink.fromJson(Map<String, dynamic> json) {
    return HyperLink(
        url: json['url'] ?? "", customText: json['customText'] ?? "");
  }

  @override
  Map<String, dynamic> getData() => {
        "url": url,
        "customText": customText,
      }..removeNullValue();
}
