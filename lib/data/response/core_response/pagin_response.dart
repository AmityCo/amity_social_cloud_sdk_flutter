class Paging {
  Paging({
    required this.next,
  });

  final String? next;

  factory Paging.fromJson(Map<String, dynamic> json) => Paging(
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "next": next,
      };
}
