class Historique {
  final int id;
  final int signalementId;
  final int? userId;
  final Map<String, dynamic> modifications;
  final String createdAt;
  final String updatedAt;
  final Map<String, dynamic>? user; // Assure-toi que c'est bien défini

  Historique({
    required this.id,
    required this.signalementId,
    this.userId,
    required this.modifications,
    required this.createdAt,
    required this.updatedAt,
    this.user,
  });

  factory Historique.fromJson(Map<String, dynamic> json) {
    return Historique(
      id: json['id'],
      signalementId: json['signalement_id'],
      userId: json['user_id'],
      modifications: json['modifications'] ?? {},
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: json['user'], // Vérifie que cette clé est bien présente
    );
  }
}
