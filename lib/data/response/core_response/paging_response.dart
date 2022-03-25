class PagingResponse {
  PagingResponse({
    required this.next,
  });

  final String? next;

  factory PagingResponse.fromJson(Map<String, dynamic> json) => PagingResponse(
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "next": next,
      };
}
