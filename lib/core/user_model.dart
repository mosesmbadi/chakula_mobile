class User {
  final String id;
  final String email;
  final String name;
  final List<String> dietaryGoals;
  final int dailyBudget;
  final String? accessToken;
  final String? refreshToken;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.dietaryGoals,
    required this.dailyBudget,
    this.accessToken,
    this.refreshToken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      dietaryGoals: List<String>.from(json['dietaryGoals'] ?? []),
      dailyBudget: json['dailyBudget'] ?? 0,
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }

  User copyWith({
    String? id,
    String? email,
    String? name,
    List<String>? dietaryGoals,
    int? dailyBudget,
    String? accessToken,
    String? refreshToken,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      dietaryGoals: dietaryGoals ?? this.dietaryGoals,
      dailyBudget: dailyBudget ?? this.dailyBudget,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }
}
