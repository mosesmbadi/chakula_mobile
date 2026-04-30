/// Notification channel preferences for one category (e.g. marketing).
class NotificationChannels {
  final bool email;
  final bool push;
  final bool whatsapp;

  const NotificationChannels({
    required this.email,
    required this.push,
    required this.whatsapp,
  });

  factory NotificationChannels.fromJson(Map<String, dynamic> json) =>
      NotificationChannels(
        email: (json['email'] as bool?) ?? false,
        push: (json['push'] as bool?) ?? false,
        whatsapp: (json['whatsapp'] as bool?) ?? false,
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'push': push,
        'whatsapp': whatsapp,
      };

  NotificationChannels copyWith({bool? email, bool? push, bool? whatsapp}) =>
      NotificationChannels(
        email: email ?? this.email,
        push: push ?? this.push,
        whatsapp: whatsapp ?? this.whatsapp,
      );
}

/// Full notifications settings object returned by GET /users/notifications.
class NotificationSettings {
  final NotificationChannels marketing;
  final NotificationChannels security;
  final NotificationChannels social;

  const NotificationSettings({
    required this.marketing,
    required this.security,
    required this.social,
  });

  factory NotificationSettings.defaults() => const NotificationSettings(
        marketing: NotificationChannels(email: true, push: false, whatsapp: false),
        security: NotificationChannels(email: true, push: true, whatsapp: true),
        social: NotificationChannels(email: false, push: true, whatsapp: false),
      );

  factory NotificationSettings.fromJson(Map<String, dynamic> json) =>
      NotificationSettings(
        marketing: NotificationChannels.fromJson(
            (json['marketing'] as Map<String, dynamic>?) ?? {}),
        security: NotificationChannels.fromJson(
            (json['security'] as Map<String, dynamic>?) ?? {}),
        social: NotificationChannels.fromJson(
            (json['social'] as Map<String, dynamic>?) ?? {}),
      );

  Map<String, dynamic> toJson() => {
        'marketing': marketing.toJson(),
        'security': security.toJson(),
        'social': social.toJson(),
      };

  NotificationSettings copyWithCategory(
    String category,
    NotificationChannels channels,
  ) {
    return NotificationSettings(
      marketing: category == 'marketing' ? channels : marketing,
      security: category == 'security' ? channels : security,
      social: category == 'social' ? channels : social,
    );
  }

  NotificationChannels forCategory(String category) => switch (category) {
        'marketing' => marketing,
        'security' => security,
        'social' => social,
        _ => throw ArgumentError('Unknown category: $category'),
      };
}
