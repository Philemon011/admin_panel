class Signalement {
  int? id;
  String? description;
  String? pieceJointe;
  String? codeDeSuivi;
  int? typeDeSignalementId;
  int? statusId;
  String? createdAt;
  String? updatedAt;
  String? date_evenement;
  String? libelle;
  String? nomStatus;
  String? commentaires;
  String? reponse;
  String? cloturer_verification;
  String? raison;

  Signalement(
      {this.id,
      this.description,
      this.pieceJointe,
      this.codeDeSuivi,
      this.typeDeSignalementId,
      this.statusId,
      this.createdAt,
      this.updatedAt,
      this.date_evenement,
      this.libelle,
      this.nomStatus,
      this.cloturer_verification,
      this.raison,
      this.reponse,
      this.commentaires,
    });

  Signalement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    pieceJointe = json['piece_jointe'];
    codeDeSuivi = json['code_de_suivi'];
    typeDeSignalementId = json['type_de_signalement_id'];
    statusId = json['status_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    date_evenement = json['date_evenement'];
    libelle = json['libelle'];
    nomStatus = json['nom_status'];
    cloturer_verification = json['cloturer_verification'];
    raison = json['raison'];
    commentaires = json['commentaires'];
    reponse = json['reponse'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['piece_jointe'] = this.pieceJointe;
    data['code_de_suivi'] = this.codeDeSuivi;
    data['type_de_signalement_id'] = this.typeDeSignalementId;
    data['status_id'] = this.statusId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['date_evenement'] = this.date_evenement;
    data['libelle'] = this.libelle;
    data['nom_status'] = this.nomStatus;
    data['cloturer_verification'] = this.cloturer_verification;
    data['raison'] = this.raison;
    data['reponse'] = this.reponse;
    data['commentaires'] = this.commentaires;
    return data;
  }
}
