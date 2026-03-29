class UserLevelInfo {
  final int level;
  final int xp;
  final int completedCount;
  final int xpForNextLevel;
  final double progress;

  const UserLevelInfo({
    required this.level,
    required this.xp,
    required this.completedCount,
    required this.xpForNextLevel,
    required this.progress,
  });

  factory UserLevelInfo.fromJson(Map<String, dynamic> json) {
    return UserLevelInfo(
      level: (json['level'] as num?)?.toInt() ?? 1,
      xp: (json['xp'] as num?)?.toInt() ?? 0,
      completedCount: (json['completedCount'] as num?)?.toInt() ?? 0,
      xpForNextLevel: (json['xpForNextLevel'] as num?)?.toInt() ?? 100,
      progress: (json['progress'] as num?)?.toDouble() ?? 0,
    );
  }
}

class UserAchievementSummary {
  final int completedCount;
  final int level;
  final int xp;
  final List<dynamic> badges;
  final List<dynamic> unlockedRecipes;

  const UserAchievementSummary({
    required this.completedCount,
    required this.level,
    required this.xp,
    required this.badges,
    required this.unlockedRecipes,
  });

  factory UserAchievementSummary.fromJson(Map<String, dynamic> json) {
    return UserAchievementSummary(
      completedCount: (json['completedCount'] as num?)?.toInt() ?? 0,
      level: (json['level'] as num?)?.toInt() ?? 1,
      xp: (json['xp'] as num?)?.toInt() ?? 0,
      badges: (json['badges'] as List?) ?? const [],
      unlockedRecipes: (json['unlockedRecipes'] as List?) ?? const [],
    );
  }
}
