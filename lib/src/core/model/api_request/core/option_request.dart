class OptionsRequest {
  OptionsRequest({
    this.limit,
    this.token,
  });

  int? limit;
  String? token;

  factory OptionsRequest.fromJson(Map<String, dynamic> json) => OptionsRequest(
        limit: json["limit"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "limit": limit,
        "token": token,
      }..removeWhere((key, value) => value == null);
}
