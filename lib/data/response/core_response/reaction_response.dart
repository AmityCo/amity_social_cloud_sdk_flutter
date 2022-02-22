class ReactionResponse {
  ReactionResponse({
    required this.like,
  });

  final int? like;

  factory ReactionResponse.fromJson(Map<String, dynamic> json) =>
      ReactionResponse(
        like: json["like"],
      );

  Map<String, dynamic> toJson() => {
        "like": like,
      };
}
