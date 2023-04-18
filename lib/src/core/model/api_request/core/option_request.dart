/// [OptionsRequest]
class OptionsRequest {
  /// init [OptionsRequest]
  OptionsRequest({this.after, this.first, this.before, this.last, this.token, this.type, this.limit});

  /// After
  int? after;

  /// First
  int? first;

  /// Before
  int? before;

  /// Last
  int? last;

  /// Token
  String? token;

  /// Type
  String? type;

  /// limit
  int? limit;

  factory OptionsRequest.fromJson(Map<String, dynamic> json) => OptionsRequest(
        after: json["after"],
        first: json["first"],
        before: json["before"],
        last: json["last"],
        token: json["token"],
        type: json["type"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "after": after,
        "first": first,
        "before": before,
        "last": last,
        "token": token,
        "type": type,
        "limit": limit,
      }..removeWhere((key, value) => value == null);
}
