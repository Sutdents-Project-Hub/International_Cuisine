class RecipeRating {
  final String id;
  final String? userId;
  final String? username;
  final int score;
  final String? comment;
  final DateTime? createdAt;

  const RecipeRating({
    required this.id,
    required this.score,
    this.userId,
    this.username,
    this.comment,
    this.createdAt,
  });

  factory RecipeRating.fromJson(Map<String, dynamic> json) {
    final user = json['user'];
    final userMap = user is Map<String, dynamic>
        ? user
        : user is Map
        ? user.map((key, value) => MapEntry(key.toString(), value))
        : const <String, dynamic>{};

    return RecipeRating(
      id: json['id']?.toString() ?? '',
      userId: json['userId']?.toString(),
      username: userMap['username']?.toString(),
      score: (json['score'] as num?)?.toInt() ?? 0,
      comment: json['comment']?.toString(),
      createdAt: DateTime.tryParse(json['createdAt']?.toString() ?? ''),
    );
  }
}
