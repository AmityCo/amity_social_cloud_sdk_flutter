class PagingResponse {
  PagingResponse({
    required this.next,
    required this.previous,
  });

  final String? next;
  final String? previous;

  factory PagingResponse.fromJson(Map<String, dynamic> json) => PagingResponse(
        next: json["next"],
        previous: json["previous"],
      );

  Map<String, dynamic> toJson() => {
        "next": next,
        "previous": previous,
      };
}
