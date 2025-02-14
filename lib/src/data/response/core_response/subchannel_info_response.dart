class SubChannelInfoResponse {
  final String subChannelId;
  final String subChannelName;
  final DateTime? createdAt;
  final DateTime? updatedAt;
 
  SubChannelInfoResponse({
    required this.subChannelId,
    required this.subChannelName,
    this.createdAt,
    this.updatedAt,
  });

  factory SubChannelInfoResponse.fromJson(Map<String, dynamic> json) {
    return SubChannelInfoResponse(
      subChannelId: json['messageFeedId'],
      subChannelName: json['name'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'messageFeedId': subChannelId,
      'name': subChannelName,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}