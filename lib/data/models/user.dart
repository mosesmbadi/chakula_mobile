class User {
  final String id;
  final String email;
  final String name;
  final List<String> dietaryGoals;
  final int dailyBudget;

  const User({
    required this.id,
    required this.email,
    required this.name,
    required this.dietaryGoals,
    required this.dailyBudget,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] as String? ?? json['id'] as String? ?? '',
      email: json['email'] as String? ?? '',
      name: json['name'] as String? ?? '',
      dietaryGoals: List<String>.from(json['dietaryGoals'] as List? ?? []),
      dailyBudget: (json['dailyBudget'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'name': name,
        'dietaryGoals': dietaryGoals,
        'dailyBudget': dailyBudget,
      };

  User copyWith({
    String? id,
    String? email,
    String? name,
    List<String>? dietaryGoals,
    int? dailyBudget,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      dietaryGoals: dietaryGoals ?? this.dietaryGoals,
      dailyBudget: dailyBudget ?? this.dailyBudget,
    );
  }
}
